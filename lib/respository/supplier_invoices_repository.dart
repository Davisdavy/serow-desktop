

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';

abstract class SupplierInvoicesRepository {
  //Brands
  Future<List<Results>> getSupplierInvoiceList(BuildContext context);
  Future<String> patchSupplierInvoice(Results result);
  Future<String> putSupplierInvoice(Results result);
  Future<String> deletedSupplierInvoice(String id, BuildContext context);
  Future<SupplierInvoices> postSupplierInvoice(String supplier, String branch, String payment_date, String no_items,List<dynamic>supplier_invoices_items, BuildContext context);


}