

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/respository/suppliers_repository.dart';

class SupplierController{
  final SuppliersRepository _repository;
  SupplierController(this._repository);
//get
  Future<List<Results> >fetchSupplierList(BuildContext context){
    return _repository.getSupplierList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchSupplier(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putSupplier(result);
  }

  //delete
  Future<String>deleteSupplier(String id, BuildContext context) async{
    return _repository.deletedSupplier(id, context);
  }

  //delete
  Future<Suppliers>postSupplier(String name, String posting_category, List<String> supplierContacts, BuildContext context) async{
    return _repository.postSupplier(name, posting_category, supplierContacts,context);
  }
}