import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandsRepository implements Repository{
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  @override
  Future<String> deletedBrand(Result result) {
    // TODO: implement deletedBrand
    throw UnimplementedError();
  }

  @override
  Future<List<Result>> getBrandList() async {
    //https://serow.herrings.co.ke/api/v1/inventory/brands/
    List<Result> resultList = [];
    var url = Uri.parse('$baseUrl/inventory/brands/');

    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMzODczOTY1LCJqdGkiOiJlY2M4MWMzOGFiMDQ0YTEzOTQ0M2Q0NzQ0YzczNDhkNCIsInVzZXJfaWQiOiI3MzkyMDhhMC1mMzRjLTQ5ZWEtYjNlNC0yMWU3OGFmZWRkZDQifQ.wWHEw4oZxJcJveA18DKWHtaOmhL7odoJsxDYLTt8LTE"
    }, );
    print('status code: ${response.statusCode}');
    var body = json.decode(response.body);//convert
    //parse
    print(body['results']);
      for (Map<String, dynamic> i in body["results"]) {
        resultList.add(Result.fromJson(i));
      }

    return resultList;

  }

  @override
  Future<String> patchCompleted(Result result) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<String> postBrand(Brands brands) {
    // TODO: implement postBrand
    throw UnimplementedError();
  }

  @override
  Future<String> putCompleted(Result result) {
    // TODO: implement putCompleted
    throw UnimplementedError();
  }

}