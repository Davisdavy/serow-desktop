import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/items.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/items_repository.dart';
import 'dart:convert';

import 'package:serow/services/services.dart';

class ItemsInventoryRepository implements ItemsRepository {
  @override
  Future<String> deletedItem(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.items}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getItemList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/forms/
    List<Results> itemList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(
      Uri.parse('${AppUrl.items}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    print('Get items status code: ${response.statusCode}');
    var body = json.decode(response.body); //convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      itemList.add(Results.fromJson(i));
    }

    return itemList;
  }

  @override
  Future<String> patchItem(Results groups) {
    // TODO: implement patchItem
    throw UnimplementedError();
  }

  @override
  Future<Items> postItem(
      String name,
      String brandId,
      String groupId,
      String subgroupId,
      String description,
      double costPrice,
      double avgPrice,
      double tradePrice,
      double retailPrice,
      double minimumPrice,
      double maximumPrice,
      double wholesalePrice,
      double minWholesalePrice,
      double maxWholesalePrice,
      double supplierPrice,
      double vatPercentage,
      double specialPrice,
      String packSize,
      String availability,
      int priority,
      String sellingOptions,
      double balance,
      double totalRevenue,
      double totalPurchases,
      BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    var response = await http.post(
      Uri.parse('${AppUrl.items}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(<dynamic, dynamic>{
        'name': name,
        'brand': brandId,
        'group': groupId,
        'subgroup': subgroupId,
        'description':description,
        'costPrice':costPrice,
        'avgPrice':avgPrice,
        'tradePrice':tradePrice,
        'retailPrice':retailPrice,
        'minimumPrice':minimumPrice,
        'maximumPrice':maximumPrice,
        'wholesalePrice':wholesalePrice,
        'minWholesalePrice':minWholesalePrice,
        'maxWholesalePrice':maxWholesalePrice,
        'supplierPrice':supplierPrice,
        'vatPercentage':vatPercentage,
        'specialPrice':specialPrice,
        'packSize':packSize,
        'availability':availability,
        'priority': priority,
        'selling_options':sellingOptions,
        'balance':balance,
        'totalRevenue':totalRevenue,
        'totalPurchases':totalPurchases,
      }),
    );
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return itemsFromJson(response.body);
  }

  @override
  Future<String> putItem(Results groups) {
    // TODO: implement putItem
    throw UnimplementedError();
  }
}
