import 'package:http/http.dart' as http;
import 'package:serow/models/inventory/shelves.dart';
import 'dart:convert';

import 'package:serow/respository/shelves_repository.dart';

class ShelvesInventoryRepository implements ShelvesRepository{
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  //Subgroups
  @override
  Future<Results> deletedShelf(String id) async{
    var url = Uri.parse('$baseUrl/inventory/shelves/${id}/');

    final http.Response response =
        await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getShelveList() async{
    //https://serow.herrings.co.ke/api/v1/inventory/shelves/
    List<Results> subgroupList = [];
    var url = Uri.parse('$baseUrl/inventory/shelves/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
    }, );
    print('Get shelves status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      subgroupList.add(Results.fromJson(i));
    }

    return subgroupList;
  }

  @override
  Future<String> patchShelf(Results shelves) async{
    var url = Uri.parse('$baseUrl/inventory/shelves/${shelves.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    },
        body:{'name': shelves.name.toString(), 'slug': shelves.location.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Shelves> postShelf(String name, String locationId)async {
    var url = Uri.parse('$baseUrl/inventory/shelves/');
    var response = await http.post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "$bearer"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'location': locationId,
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return shelvesFromJson(response.body);
  }

  @override
  Future<String> putShelf(Results shelf) async {
    var url = Uri.parse('$baseUrl/inventory/locations/${shelf.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    }, body:{'name': shelf.name.toString(), 'slug': shelf.location.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
  
}