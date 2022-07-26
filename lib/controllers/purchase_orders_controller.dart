
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';
import 'package:serow/repository/purchase_orders_repository.dart';

class PurchaseOrdersController {
  final PurchaseOrdersRepository _repository;
  PurchaseOrdersController(this._repository);
//get
  Future<List<PurchaseOrders>> fetchPurchaseOrderList(BuildContext context) {
    return _repository.getPurchaseOrderList(context);
  }

  Future<List<PurchaseOrders>> fetchMultiPurchaseOrderList(BuildContext context) {
    return _repository.getPurchaseOrderList(context);
  }

  //patch
  Future<String> updatePatchCompleted(PurchaseOrders result) async {
    return _repository.patchPurchaseOrder(result);
  }

  //put
  Future<String> updatePutCompleted(PurchaseOrders result) async {
    return _repository.putPurchaseOrder(result);
  }

  //delete
  Future<String> deletePurchaseOrder(String id, BuildContext context) async {
    return _repository.deletedPurchaseOrder(id, context);
  }

  //delete
  Future postPurchaseOrder(String supplier, String branch,
      double tradeDiscountPercentage,
      Decimal totalAmount, Decimal discountAmount, String expectedDate,
      double totalNetAmount, Decimal taxAmount, List<Map<String, dynamic>> purchaseOrderItemList,
      BuildContext context) async {
    return _repository.postPurchaseOrder(
         supplier,  branch,
        tradeDiscountPercentage,
         totalAmount,  discountAmount, expectedDate,
         totalNetAmount,  taxAmount, purchaseOrderItemList,
         context);
  }
}
