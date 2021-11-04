

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/branches_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';

class BranchesEntitiesRepository implements BranchesRepository {
  @override
  Future<String> deletedBranch(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.branches}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getBranchList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/inventory/branches/
    //ToDo: Pass ?all=True to get un-paginated data
    List<Results> resultList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.branches}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get branch status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      resultList.add(Results.fromJson(i));
    }

    return resultList;
  }

  @override
  Future<String> patchBranch(Results result) async {
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.branches}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.location.toString(), 'country': result.company.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;

  }

  @override
  Future<Branches> postBranch(String name, String location, String phone, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.branches}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'location': location,
      'phone': phone
    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return branchesFromJson(response.body);
  }

  @override
  Future<String> putBranch(Results result)async {
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.branches}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.location.toString(), 'country': result.phone.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }
  
}