
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/purchase_orders_repository.dart';
import 'package:serow/services/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PurchaseOrdersSupplierRepository implements PurchaseOrdersRepository {
  @override
  Future<String> deletedPurchaseOrder(String id, BuildContext context)async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
    await http.delete(Uri.parse('${AppUrl.purchase_orders}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getPurchaseOrderList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/suppliers/purchase-orders/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.purchase_orders}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get purchase orders status code: ${response.statusCode}');
    if(response.statusCode == 200) {
      var body = json.decode(response.body); //convert
      //parse
      print('Result body: ${body['results']}');
      for (Map<String, dynamic> i in body["results"]) {
        subgroupList.add(Results.fromJson(i));
      }
    } else if(response.statusCode == 401){
      //refresh token and call getUser again
      final response =  await http.get(Uri.parse('${AppUrl.purchase_orders}'),
          headers: {'grant_type': 'refresh_token', 'refresh_token': '${user.refreshToken}'});
      var body = json.decode(response.body);
      for (Map<String, dynamic> i in body["results"]) {
        subgroupList.add(Results.fromJson(i));
      }
      // token = jsonDecode(response.body)['token'];
      // refresh_token = jsonDecode(response.body)['refresh_token'];
      // return getUser();
    }
    return subgroupList;
  }

  @override
  Future<String> patchPurchaseOrder(Results result) {
    // TODO: implement patchPurchaseOrder
    throw UnimplementedError();
  }

  @override
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch, List<dynamic> purchase_order_items, BuildContext context) async{
    List grnItemList = [];
    purchase_order_items.map((item) => grnItemList.add(item.toJson())).toList();

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
    return purchaseOrdersFromJson(response.body);
  }

  @override
  Future<String> putPurchaseOrder(Results result) {
    // TODO: implement putPurchaseOrder
    throw UnimplementedError();
  }

}