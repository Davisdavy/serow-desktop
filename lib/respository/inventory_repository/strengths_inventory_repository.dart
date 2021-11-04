import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/strengths.dart';
import 'package:serow/respository/auth_provider.dart';
import 'dart:convert';

import 'package:serow/respository/strengths_repository.dart';
import 'package:serow/services/services.dart';

class StrengthInventoryRepository implements StrengthsRepository {


  @override
  Future<String> deletedStrength(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;

    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.strengths}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getStrengthsList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/inventory/stengths/
    List<Results> resultList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.strengths}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get strength status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      resultList.add(Results.fromJson(i));
    }

    return resultList;
  }

  @override
  Future<String> patchStrength(Results result) async {

    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.strengths}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.shortName.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Strengths> postStrength(String name, String shortName, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.strengths}'),headers: {
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
    return strengthsFromJson(response.body);
  }

  @override
  Future<String> putStrength(Results result) async {

    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.strengths}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.shortName.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }


}