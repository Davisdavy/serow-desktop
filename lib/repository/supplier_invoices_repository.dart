

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';

abstract class SupplierInvoicesRepository {
  //Brands
  Future<List<SupplierInvoices>> getSupplierInvoiceList(BuildContext context);
  Future<String> patchSupplierInvoice(SupplierInvoices result);
  Future<String> putSupplierInvoice(SupplierInvoices result);
  Future<String> deletedSupplierInvoice(String id, BuildContext context);
  Future<SupplierInvoices> postNewSupplierInvoice(String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate, double discountAmount,
      double totalNet, double vatAmount, double totalAmount, String status, List<Map<String, dynamic>> listItems,
      BuildContext context);
  Future<SupplierInvoices> postSupplierInvoice(

      String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate, double discountAmount,
      double totalNet, double vatAmount, double totalAmount, String status,
      String item, double itemQty,
      double unitPrice, double bonus,
      double itemTotalQty, String expiryDate, String batchNo, double itemDiscPercentage, double itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount, double totalCost,
      double itemTotalAmount, BuildContext context
      );


}