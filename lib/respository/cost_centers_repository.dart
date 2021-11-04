

import 'package:flutter/material.dart';
import 'package:serow/models/accounts/cost_centers.dart';

abstract class CostCentersRepository {
  //Cost centers
  Future<List<Results>> getCostCenterList(BuildContext context);
  Future<String> patchCostCenter(Results result);
  Future<String> putCostCenter(Results result);
  Future<String> deletedCostCenter(String id, BuildContext context);
  Future<CostCenters> postCostCenter(String name, String location, BuildContext context);


}