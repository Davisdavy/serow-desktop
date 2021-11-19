// import 'dart:convert';
//
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';
// import 'package:serow/models/auth/auth.dart';
// import 'package:serow/models/customers/customers.dart';
// import 'package:serow/repository/auth_provider.dart';
// import 'package:serow/repository/customers_repository.dart';
// import 'package:serow/services/services.dart';
// import 'package:http/http.dart' as http;
//
//
// class CustomersAPIRepository implements CustomersRepository {
//   @override
//   Future<String> deletedCustomers(String id, BuildContext context) {
//     // TODO: implement deletedCustomers
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<List<Results>> getCustomersList(BuildContext context) async{
//     //https://serow.herrings.co.ke/api/v1/inventory/brands/
//     //ToDo: Pass ?all=True to get un-paginated data
//     List<Results> resultList = [];
//     context.watch<AuthProvider>();
//     Auth user = Provider.of<AuthProvider>(context).auth;
//     var response = await http.get(Uri.parse('${AppUrl.customers}'), headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       "Authorization": "Bearer ${user.accessToken.toString()}"
//     }, );
//     print('Get customers status code: ${response.statusCode}');
//     var body = json.decode(response.body);//convert
//     //parse
//     print('Result body: ${body['results']}');
//     for (Map<String, dynamic> i in body["results"]) {
//       resultList.add(Results.fromJson(i));
//     }
//
//     return resultList;
//
//   }
//
//   @override
//   Future<String> patchCustomers(Results result) {
//     // TODO: implement patchCustomers
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Customers> postCustomers(String name, String shortName, String country, BuildContext context) {
//     // TODO: implement postCustomers
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<String> putCustomers(Results result) {
//     // TODO: implement putCustomers
//     throw UnimplementedError();
//   }
// }