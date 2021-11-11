import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/suppliers_repository.dart';
import 'package:serow/services/services.dart';
import 'package:http/http.dart' as http;

class SuppliersProvider implements SuppliersRepository {
  @override
  Future<String> deletedSupplier(String id, BuildContext context) async {
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.suppliers}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getSupplierList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/suppliers/posting-categories/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    final response = await http.get(
      Uri.parse('${AppUrl.suppliers}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      subgroupList.add(Results.fromJson(i) );
    }

    return subgroupList;
    // return subgroupList;
  }

  @override
  Future<String> patchSupplier(Results result) async {
    //call back
    String responseData = '';

    await http.patch(Uri.parse('${AppUrl.suppliers}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body: {
      'name': result.name.toString(),
    }).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Suppliers> postSupplier(String name, String postingCategory,
      String sName, String email, String physicalAddress, String phone, BuildContext context) async {
    List<Map<String, dynamic>> supplierContactsList = [
      {'name':sName,
        'email': email,
        'physical_address':physicalAddress,
        'phone': phone}
    ];
   var body={
      'name': name,
      'posting_category': postingCategory,
      "supplier_contacts":   supplierContactsList,
    };

    print("Body: $body");
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    var response = await http.post(
      Uri.parse('${AppUrl.suppliers}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
          'Charset': 'utf-8',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(body),
    );
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
     return suppliersFromJson(response.body);
  }

  @override
  Future<String> putSupplier(Results result) {
    // TODO: implement putAccount
    throw UnimplementedError();
  }
}
