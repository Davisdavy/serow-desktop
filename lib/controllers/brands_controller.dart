
import 'package:flutter/material.dart';
import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/brands_repository.dart';

class BrandsController{
  final BrandsRepository _repository;
  BrandsController(this._repository);

  //get
  Future<List<Results> >fetchBrandList(BuildContext context){
    return _repository.getBrandList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchBrand(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putBrand(result);
  }

  //delete
  Future<String>deleteBrand(String id, BuildContext context) async{
    return _repository.deletedBrand(id, context);
  }

  //delete
  Future<Brands>postBrand(String name, String shortName, String country, BuildContext context) async{
    return _repository.postBrand(name,shortName,country, context);
  }
}