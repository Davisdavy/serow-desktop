
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/goods_received_notes.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/goods_received_notes_repository.dart';
import 'package:serow/services/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoodsReceivedNotesSupplierRepository implements GoodsReceivedNotesRepository {
  @override
  Future<String> deletedGoodsReceivedNote(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.goods_received_notes}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getGoodsReceivedNoteList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/suppliers/posting-categories/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.goods_received_notes}'), headers: {
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
  Future<String> patchGoodsReceivedNote(Results result) {
    // TODO: implement patchGoodsReceivedNote
    throw UnimplementedError();
  }

  @override
  Future<GoodsReceivedNotes> postGoodsReceivedNote(String supplier, String branch, List<dynamic> grn_items, BuildContext context)async {
    List grnItemList = [];
    grn_items.map((item) => grnItemList.add(item.toJson())).toList();

    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.suppliers}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, dynamic>{
      'supplier': supplier,
      "branch": branch,
      'grn_items': grnItemList
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return goodsReceivedNotesFromJson(response.body);
  }

  @override
  Future<String> putGoodsReceivedNote(Results result) {
    // TODO: implement putGoodsReceivedNote
    throw UnimplementedError();
  }

}