import 'package:http/http.dart' as http;
import 'package:serow/models/inventory/pricing.dart';
import 'dart:convert';

import 'package:serow/respository/pricing_repository.dart';

class PricingInventoryRepository implements PricingRepository {
  String baseUrl = 'https://serow.herrings.co.ke/api/v1';
  String bearer = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjM0NjU5MDY1LCJqdGkiOiIxNTRjZDE1NzU3Mzc0M2RkYTMzZjI2MDY0OTdiOWFlZSIsInVzZXJfaWQiOiJlOWJlZmRlYS1jOWEyLTRiYjYtYjFmMy02MDE1NTJlNTU1NTgifQ.itFBwtHrgJNbpjNaw-4_8jeVxKpB9uJClaz-1zjjg4U';

  @override
  Future<Results> deletedPricing(String id) {
    // TODO: implement deletedLocation
    throw UnimplementedError();
  }

  @override
  Future<List<Results>> getPricingList() {
    // TODO: implement getLocationList
    throw UnimplementedError();
  }

  @override
  Future<String> patchPricing(Results groups) {
    // TODO: implement patchLocation
    throw UnimplementedError();
  }

  @override
  Future<Pricing> postPricing(String name, List<PricingFormulas> pricingFormulas) {
    // TODO: implement postLocation
    throw UnimplementedError();
  }

  @override
  Future<String> putPricing(Results groups) {
    // TODO: implement putLocation
    throw UnimplementedError();
  }
}