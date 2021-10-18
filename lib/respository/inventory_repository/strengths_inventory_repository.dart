import 'package:http/http.dart' as http;
import 'package:serow/models/inventory/strengths.dart';
import 'dart:convert';

import 'package:serow/respository/strengths_repository.dart';

class StrengthInventoryRepository implements StrengthsRepository {

  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  @override
  Future<Results> deletedStrength(String id) async{
    var url = Uri.parse('$baseUrl/inventory/strengths/${id}/');

    final http.Response response =
        await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getStrengthsList() async{
    //https://serow.herrings.co.ke/api/v1/inventory/stengths/
    List<Results> resultList = [];
    var url = Uri.parse('$baseUrl/inventory/strengths/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
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
    var url = Uri.parse('$baseUrl/inventory/strengths/${result.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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
  Future<Strengths> postStrength(String name, String shortName) async{
    var url = Uri.parse('$baseUrl/inventory/strengths/');
    var response = await http.post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "$bearer"
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
    var url = Uri.parse('$baseUrl/inventory/strengths/${result.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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