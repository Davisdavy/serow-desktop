

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/repository/suppliers_repository.dart';

class SupplierController{
  final SuppliersRepository _repository;
  SupplierController(this._repository);
//get
  Future<List<Suppliers> >fetchSupplierList(BuildContext context){
    return _repository.getSupplierList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Suppliers result) async{
    return _repository.patchSupplier(result);
  }

  //put
  Future<String >updatePutCompleted(Suppliers result) async{
    return _repository.putSupplier(result);
  }

  //delete
  Future<String>deleteSupplier(String id, BuildContext context) async{
    return _repository.deletedSupplier(id, context);
  }

  //delete
  Future<Suppliers>postSupplier(String name, String posting_category, String sName, String email, String physicalAddress, String phone, BuildContext context) async{
    return _repository.postSupplier(name, posting_category, sName, email, physicalAddress, phone,context);
  }
}