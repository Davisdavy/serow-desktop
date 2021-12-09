
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';
import 'package:serow/repository/supplier_invoices_repository.dart';

class SupplierInvoicesController {
  final SupplierInvoicesRepository _repository;
  SupplierInvoicesController(this._repository);
//get
  Future<List<SupplierInvoices>> fetchSupplierInvoiceList(BuildContext context) {
    return _repository.getSupplierInvoiceList(context);
  }

  //patch
  Future<String> updatePatchCompleted(SupplierInvoices result) async {
    return _repository.patchSupplierInvoice(result);
  }

  //put
  Future<String> updatePutCompleted(SupplierInvoices result) async {
    return _repository.putSupplierInvoice(result);
  }

  //delete
  Future<String> deleteSupplierInvoice(String id, BuildContext context) async {
    return _repository.deletedSupplierInvoice(id, context);
  }

  Future<SupplierInvoices> postNewSupplierInvoice(String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate, double discountAmount,
      double totalNet, double vatAmount, double totalAmount, String status, List<Map<String, dynamic>> listItems,
      BuildContext context) async{
    return _repository.postNewSupplierInvoice(supplier, branch, purchaseOrderId, tradeDiscPercentage, receivedDate, discountAmount, totalNet, vatAmount, totalAmount, status, listItems, context);
  }

  //delete
  Future<SupplierInvoices> postSupplierInvoice(String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate, double discountAmount,
      double totalNet, double vatAmount, double totalAmount, String status,
      String item, double itemQty,
      double unitPrice, double bonus,
      double itemTotalQty, String expiryDate, String batchNo, double itemDiscPercentage, double itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount, double totalCost,
      double itemTotalAmount, BuildContext context) async {
    return _repository.postSupplierInvoice(
         supplier,  branch,
        purchaseOrderId,  tradeDiscPercentage,  receivedDate,  discountAmount,
         totalNet,  vatAmount,  totalAmount,  status,
         item,  itemQty,
         unitPrice,  bonus,
         itemTotalQty,  expiryDate,  batchNo,  itemDiscPercentage,  itemDiscAmount,
         itemNetAmount,  itemVATPercentage,
         itemVATAmount, totalCost,
         itemTotalAmount,  context
    );
  }
}
