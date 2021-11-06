

import 'package:serow/models/inventory/pricing.dart';

abstract class PricingRepository {
//subgroups
  Future<List<Results>> getPricingList();

  Future<String> patchPricing(Results groups);

  Future<String> putPricing(Results groups);

  Future<Results> deletedPricing(String id);

  Future<Pricing> postPricing(String name, List<PricingFormulas> pricingFormulas);

}