import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/brands_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';


class BrandsInventoryRepository implements BrandsRepository {

  //Brands
  @override
  Future<String> deletedBrand(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
  final http.Response response =
  await http.delete(Uri.parse('${AppUrl.brands}$id/'), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    "Authorization": "Bearer ${user.accessToken.toString()}",
  });
   return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getBrandList( BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/brands/
    //ToDo: Pass ?all=True to get un-paginated data
    List<Results> resultList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.brands}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get brands status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
      for (Map<String, dynamic> i in body["results"]) {
        resultList.add(Results.fromJson(i));
      }

    return resultList;

  }

  @override
  Future<String> patchBrand(Results result) async {
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.brands}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.shortName.toString(), 'country': result.country.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;

  }

  @override
  Future<Brands> postBrand(String name, String shortName, String country, BuildContext context)  async {
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.brands}'),headers: {
      'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'short_name': shortName,
      'country': ''
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
   // print('Post toJSON: ${br}');
    return brandsFromJson(response.body);
  }

  //Modify passed variables only and treat other variables as NULL or Default
  @override
  Future<String> putBrand(Results result) async {
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.brands}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.shortName.toString(), 'country': result.country.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }


}

