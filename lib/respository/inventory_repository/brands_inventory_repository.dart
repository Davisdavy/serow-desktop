import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/brands_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandsInventoryRepository implements BrandsRepository{
  
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  //Brands
  @override
  Future<Results> deletedBrand(String id) async{
  var url = Uri.parse('$baseUrl/inventory/brands/${id}/');

  final http.Response response =
  await http.delete(url, headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "$bearer",
  });

  return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getBrandList() async {
    //https://serow.herrings.co.ke/api/v1/inventory/brands/
    List<Results> resultList = [];
    var url = Uri.parse('$baseUrl/inventory/brands/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
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
    var url = Uri.parse('$baseUrl/inventory/brands/${result.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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
  Future<Brands> postBrand(String name, String shortName, String country)  async {
    var url = Uri.parse('$baseUrl/inventory/brands/');
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
    return brandsFromJson(response.body);
  }

  //Modify passed variables only and treat other variables as NULL or Default
  @override
  Future<String> putBrand(Results result) async {
    var url = Uri.parse('$baseUrl/inventory/brands/${result.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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