import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/groups.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/group_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';

class GroupsInventoryRepository implements GroupsRepository{

  //Groups

  @override
  Future<List<Results>> getGroupList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/groups/
    List<Results> groupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.groups}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
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
  Future<Results> deletedGroup(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
    await http.delete(Uri.parse('${AppUrl.groups}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return  Results.fromJson(json.decode(response.body.toString()));
  }

  @override
  Future<String> patchGroup(Results groups) async {

    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.groups}${groups.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
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
  Future<Group> postGroup(String name, String priority, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.groups}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
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
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.groups}${groups.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
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