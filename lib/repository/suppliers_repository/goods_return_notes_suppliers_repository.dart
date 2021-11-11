import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/goosd_return_notes_repository.dart';
import 'package:serow/services/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoodsReturnNotesSupplierRepository implements GoodsReturnNotesRepository {
  @override
  Future<String> deletedGoodsReturnNote(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.goods_return_notes}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getGoodsReturnNoteList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/suppliers/goods-return-note/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.goods_return_notes}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get goods received notes status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      subgroupList.add(Results.fromJson(i));
    }

    return subgroupList;
  }

  @override
  Future<String> patchGoodsReturnNote(Results result) {
    // TODO: implement patchGoodsReceivedNote
    throw UnimplementedError();
  }

  @override
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,
      String item, int quantity, int detailQuantity, String detailLocation, double discountAmount,
      String batchNo, String expDate,double totalAmount, double totalCost,
      BuildContext context) async {
    List<Map<String, dynamic>> grnItemsDetailList = [

      {'location':detailLocation,
        'quantity': detailQuantity,
        'batch_number':batchNo,
        'expiry_date': expDate
      }
    ];
    List<Map<String, dynamic>> grnItemsList = [
      {'item':item,
        'quantity': quantity,
        'goods_return_note_item_details':grnItemsDetailList,
        }
    ];

    var body={
      'supplier': supplier,
      'branch': branch,
      'discount_amount': discountAmount,
      'total_amount':totalAmount,
      "goods_return_note_items":   grnItemsList,
    };
    print("GRN Body: $body");
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.goods_return_notes}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(body),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return goodsReturnNotesFromJson(response.body);
  }

  @override
  Future<String> putGoodsReturnNote(Results result) {
    // TODO: implement putGoodsReceivedNote
    throw UnimplementedError();
  }

}