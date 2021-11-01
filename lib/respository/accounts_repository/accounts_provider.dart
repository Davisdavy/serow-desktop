
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/accounts/accounts.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/respository/accounts_repository.dart';
import 'package:serow/respository/auth_provider.dart';
import 'package:serow/services/services.dart';

class AccountsProvider implements AccountsRepository {
  @override
  Future<Results> deletedAccount(String id, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.accounts}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return  Results.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Results>> getAccountsList(BuildContext context)async {
    //https://serow.herrings.co.ke/api/v1/accounts/costcenters/
    //ToDo: Pass ?all=True to get un-paginated data
    List<Results> resultList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;
    var response = await http.get(Uri.parse('${AppUrl.accounts}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get accounts status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print('Result body: ${body['results']}');
    for (Map<String, dynamic> i in body["results"]) {
      resultList.add(Results.fromJson(i));
    }

    return resultList;
  }

  @override
  Future<String> patchAccounts(Results result) {
    // TODO: implement patchAccounts
    throw UnimplementedError();
  }

  @override
  Future<Accounts> postAccount(String name, String code, String group, String costCenter, BuildContext context) async{
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.accounts}'),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":  "Bearer ${user.accessToken.toString()}"
    }, body: jsonEncode(<dynamic, String>{
      'name': name,
      'code': code,
      "group": group,
      "cost-center": costCenter

    }),);
    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return accountsFromJson(response.body);
  }

  @override
  Future<String> putAccount(Results result) {
    // TODO: implement putAccount
    throw UnimplementedError();
  }
}