import 'package:serow/models/inventory/pricing.dart';

import 'package:serow/respository/pricing_repository.dart';

class PricingInventoryRepository implements PricingRepository {

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