

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/posting_categories.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/posting_categories_repository.dart';
import 'dart:convert';

import 'package:serow/services/services.dart';

class PostingCategoriesSuppliersRepository implements PostingCategoriesRepository {
  @override
  Future<Results> deletedPostingCategory(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.posting_categories}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getPostingCategoryList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/suppliers/posting-categories/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.posting_categories}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get posting categories status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      subgroupList.add(Results.fromJson(i));
    }

    return subgroupList;
  }

  @override
  Future<String> patchPostingCategory(Results results) async{
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.posting_categories}${results.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    },
        body:{'name': results.name.toString(), 'code': results.code.toString(), 'account': results.account.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<PostingCategories> postPostingCategory(String name, String code, String accountId, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.posting_categories}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'code': code,
      'account':accountId
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return postingCategoriesFromJson(response.body);
  }

  @override
  Future<String> putPostingCategory(Results groups) async{
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.posting_categories}${groups.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': groups.name.toString(), 'code': groups.code.toString(), 'account': groups.account.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

}
