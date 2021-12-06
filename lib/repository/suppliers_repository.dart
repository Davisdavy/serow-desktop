

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/suppliers.dart';

abstract class SuppliersRepository {
  //Brands
  Future<List<Suppliers >> getSupplierList(BuildContext context);
  Future<String> patchSupplier(Suppliers result);
  Future<String> putSupplier(Suppliers result);
  Future<String> deletedSupplier(String id, BuildContext context);
  Future<Suppliers> postSupplier(String name, String postingCategory, String sName, String email, String physicalAddress, String phone, BuildContext context);


}