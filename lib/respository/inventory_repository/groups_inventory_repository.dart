import 'package:serow/models/inventory/groups.dart';
import 'package:serow/respository/group_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupsInventoryRepository implements GroupsRepository{
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NTk3NDE5LCJqdGkiOiI5OWI5N2FjMjQ5ZDI0ZDY4YmY5MzUyOWMwZTkyNmFjZCIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.vbWhAbW8TR03GpEWHMAX9bLP65GcUbFnZNAMoq9Yz6A';

  //Groups

  @override
  Future<List<Results>> getGroupList() async {
    //https://serow.herrings.co.ke/api/v1/inventory/groups/
    List<Results> groupList = [];
    var url = Uri.parse('$baseUrl/inventory/groups/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "$bearer"
    }, );
    print('Get groups status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      groupList.add(Results.fromJson(i));
    }

    return groupList;

  }


  @override
  Future<Results> deletedGroup(String id) async {
    var url = Uri.parse('$baseUrl/inventory/groups/${id}/');

    final http.Response response =
    await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<String> patchGroup(Results groups) async {
    var url = Uri.parse('$baseUrl/inventory/groups/${groups.id}');
    //call back
    String responseData = '';
    await http.patch(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    },
        body:{'name': groups.name.toString(), 'slug': groups.slug.toString(), 'priority': groups.priority.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<Groups> postGroup(String name, String priority,) async{
    var url = Uri.parse('$baseUrl/inventory/groups/');
    var response = await http.post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "$bearer"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'priority': priority,

    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return groupFromJson(response.body);
  }

  @override
  Future<String> putGroup(Results groups)async {
    var url = Uri.parse('$baseUrl/inventory/groups/${groups.id}');
    //call back
    String responseData = '';
    await http.put(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "$bearer"
    }, body:{'name': groups.name.toString(), 'slug': groups.slug.toString(), 'country': groups.priority.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
}