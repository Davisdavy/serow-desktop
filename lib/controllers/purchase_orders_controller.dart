
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
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch,
      String item,double tradeDiscountPercentage,
      double totalAmount, double discountAmount, String expectedDate,
      double totalNetAmount, double taxAmount,
      double itemQuantity, double itemUnitCost,
      double itemBonus, double itemDiscountPercentage,
      double itemDiscountAmount, double itemNetAmount,
      double itemTaxPercentage, double itemTaxAmount,
      double itemTotalCost,
      BuildContext context) async {
    return _repository.postPurchaseOrder(
         supplier,  branch,
         item, tradeDiscountPercentage,
         totalAmount,  discountAmount, expectedDate,
         totalNetAmount,  taxAmount,
         itemQuantity, itemUnitCost,
         itemBonus,  itemDiscountPercentage,
         itemDiscountAmount,  itemNetAmount,
         itemTaxPercentage,  itemTaxAmount,
         itemTotalCost,
         context);
  }
}
