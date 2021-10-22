import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/inventory/locations.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/respository/locations_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serow/services/services.dart';

class LocationsInventoryRepository implements LocationsRepository{

  //Subgroups
  @override
  Future<Results> deletedLocation(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
    await http.delete(Uri.parse('${AppUrl.locations}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getLocationList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/inventory/brands/
    List<Results> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.locations}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
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

    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.locations}${results.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
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
  Future<Locations> postLocation(String name, String code, String branchId, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.locations}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
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
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.locations}${results.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
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