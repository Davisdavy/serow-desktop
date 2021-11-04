
import 'package:flutter/material.dart';
import 'package:serow/models/accounts/cost_centers.dart';
import 'package:serow/respository/cost_centers_repository.dart';

class CostCentersController{
  final CostCentersRepository _repository;
  CostCentersController(this._repository);
  //get
  Future<List<Results> >fetchCostCenterList(BuildContext context){
    return _repository.getCostCenterList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchCostCenter(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putCostCenter(result);
  }

  //delete
  Future<String>deleteCostCenter(String id, BuildContext context) async{
    return _repository.deletedCostCenter(id, context);
  }

  //delete
  Future<CostCenters>postBrand(String name, String code,BuildContext context) async{
    return _repository.postCostCenter(name,code,context);
  }
}