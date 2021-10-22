import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/forms.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/forms_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';

class FormsInventoryRepository implements FormsRepository {

  @override
  Future<Results> deletedForms(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;

    final http.Response response = await http.delete(Uri.parse('${AppUrl.forms}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getFormsList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/forms/
    List<Results> groupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(
      Uri.parse('${AppUrl.forms}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    print('Get groups status code: ${response.statusCode}');
    var body = json.decode(response.body); //convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      groupList.add(Results.fromJson(i));
    }

    return groupList;
  }

  @override
  Future<String> patchForms(Results result) async {
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.brands}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body: {
      'name': result.name.toString(),
      'priority': result.shortName.toString()
    }).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Forms> postForms(String name, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(
      Uri.parse('${AppUrl.brands}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(<dynamic, String>{
        'name': name,
      }),
    );
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return formsFromJson(response.body);
  }

  @override
  Future<String> putForms(Results result) async {

    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.brands}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body: {
      'name': result.name.toString(),
      'country': result.shortName.toString()
    }).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
}
