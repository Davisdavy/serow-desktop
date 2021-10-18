import 'package:serow/models/inventory/categories.dart';
import 'package:serow/respository/categories_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesInventoryRepository implements CategoriesRepository{
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  @override
  Future<Result> deletedCategory(String id) async{
    var url = Uri.parse('$baseUrl/inventory/categories/${id}/');

    final http.Response response =
    await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer",
    });

    return  Result.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Result>> getCategoryList() async {
    //https://serow.herrings.co.ke/api/v1/inventory/categories/
    List<Result> categoryList = [];
    var url = Uri.parse('$baseUrl/inventory/categories/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
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
    var url = Uri.parse('$baseUrl/inventory/categories/${categories.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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
  Future<Categories> postCategory(String name, String group, String subgroup) async{
    var url = Uri.parse('$baseUrl/inventory/categories/');
    var response = await http.post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "$bearer"
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
    var url = Uri.parse('$baseUrl/inventory/categories/${categories.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
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