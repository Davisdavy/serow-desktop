import 'package:serow/models/inventory/locations.dart';
import 'package:serow/respository/locations_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationsInventoryRepository implements LocationsRepository{
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  //Subgroups
  @override
  Future<Results> deletedLocation(String id) async {
    var url = Uri.parse('$baseUrl/inventory/locations/${id}/');

    final http.Response response =
    await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getLocationList() async {
    //https://serow.herrings.co.ke/api/v1/inventory/brands/
    List<Results> subgroupList = [];
    var url = Uri.parse('$baseUrl/inventory/locations/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
    }, );
    print('Get subgroups status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      subgroupList.add(Results.fromJson(i));
    }

    return subgroupList;
  }

  @override
  Future<String> patchLocation(Results results) async {
    var url = Uri.parse('$baseUrl/inventory/locations/${results.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    },
        body:{'name': results.name.toString(), 'slug': results.code.toString(), 'priority': results.branch.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Locations> postLocation(String name, String code, String branchId) async {
    var url = Uri.parse('$baseUrl/inventory/locations/');
    var response = await http.post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "$bearer"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'code': code,
      'branch': branchId
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return locationsFromJson(response.body);
  }

  @override
  Future<String> putLocation(Results results) async {
    var url = Uri.parse('$baseUrl/inventory/locations/${results.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    }, body:{'name': results.name.toString(), 'slug': results.code.toString(), 'country': results.branch.id.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
}