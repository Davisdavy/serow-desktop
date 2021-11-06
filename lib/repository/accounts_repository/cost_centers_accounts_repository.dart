
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:serow/models/accounts/cost_centers.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/cost_centers_repository.dart';
import 'dart:convert';

import 'package:serow/services/services.dart';

class CostCentersAccountsRepository implements CostCentersRepository {
  @override
  Future<String> deletedCostCenter(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.cost_centers}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<Results>> getCostCenterList(BuildContext context) async {
    //https://serow.herrings.co.ke/api/v1/accounts/costcenters/
    //ToDo: Pass ?all=True to get un-paginated data
    List<Results> resultList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.cost_centers}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get cost centers status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      resultList.add(Results.fromJson(i));
    }

    return resultList;
  }

  @override
  Future<String> patchCostCenter(Results result) async {
    //call back
    String responseData = '';
    await http.patch(Uri.parse('${AppUrl.cost_centers}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.code.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Patch result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

  @override
  Future<CostCenters> postCostCenter(String name, String code, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.cost_centers}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'code': code

    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return costCentersFromJson(response.body);
  }

  @override
  Future<String> putCostCenter(Results result)async {
    //call back
    String responseData = '';
    await http.put(Uri.parse('${AppUrl.cost_centers}${result.id}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer "
    }, body:{'name': result.name.toString(), 'short_name': result.code.toString()}
    ).then((response) {
      //screen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      print('Put result: $result');
      return responseData = result['name'];
    });
    return responseData;
  }

}