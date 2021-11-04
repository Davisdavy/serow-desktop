

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/suppliers.dart';

abstract class SuppliersRepository {
  //Brands
  Future<List<Results>> getSupplierList(BuildContext context);
  Future<String> patchSupplier(Results result);
  Future<String> putSupplier(Results result);
  Future<String> deletedSupplier(String id, BuildContext context);
  Future<Suppliers> postSupplier(String name, String postingCategory,List<String>supplier_contacts, BuildContext context);


}