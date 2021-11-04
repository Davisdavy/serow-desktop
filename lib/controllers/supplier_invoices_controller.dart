
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';
import 'package:serow/respository/supplier_invoices_repository.dart';

class SupplierInvoicesController {
  final SupplierInvoicesRepository _repository;
  SupplierInvoicesController(this._repository);
//get
  Future<List<Results>> fetchSupplierInvoiceList(BuildContext context) {
    return _repository.getSupplierInvoiceList(context);
  }

  //patch
  Future<String> updatePatchCompleted(Results result) async {
    return _repository.patchSupplierInvoice(result);
  }

  //put
  Future<String> updatePutCompleted(Results result) async {
    return _repository.putSupplierInvoice(result);
  }

  //delete
  Future<String> deleteSupplierInvoice(String id, BuildContext context) async {
    return _repository.deletedSupplierInvoice(id, context);
  }

  //delete
  Future<SupplierInvoices> postSupplierInvoice(String supplier, String branch, String payment_date, String no_items,
      List<dynamic> purchase_order_items, BuildContext context) async {
    return _repository.postSupplierInvoice(
        supplier, branch, payment_date, no_items, purchase_order_items, context);
  }
}
