import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/categories.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/categories_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';

class CategoriesInventoryRepository implements CategoriesRepository{

  @override
  Future<String> deletedCategory(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;

    final http.Response response =
    await http.delete(Uri.parse('${AppUrl.categories}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });


    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Result>> getCategoryList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/categories/
    List<Result> categoryList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.categories}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get get categories status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Categories body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      categoryList.add(Result.fromJson(i));
    }

    return categoryList;
  }

  @override
  Future<String> patchCategory(Result categories) async{
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.categories}${categories.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    },
        body:{'name': categories.name.toString(), 'slug': categories.slug.toString(), 'priority': categories.group.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Categories> postCategory(String name, String group, String subgroup, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.categories}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'group': group,
      'subgroup': subgroup
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return categoriesFromJson(response.body);
  }

  @override
  Future<String> putCategory(Result categories) async{
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.brands}${categories.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': categories.name.toString(), 'slug': categories.slug.toString(), 'country': categories.group.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
}