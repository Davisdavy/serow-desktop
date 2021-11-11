
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';

abstract class PurchaseOrdersRepository {
  //Brands
  Future<List<Results>> getPurchaseOrderList(BuildContext context);
  Future<String> patchPurchaseOrder(Results result);
  Future<String> putPurchaseOrder(Results result);
  Future<String> deletedPurchaseOrder(String id, BuildContext context);
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch,
      String item, int itemQuantity, double itemUnitCost,
      double itemBonus, double itemDiscountPercentage,
      double itemDiscountAmount, double itemNetAmount,
      double itemTaxPercentage, double itemTaxAmount,
      double itemTotalCost, double totalAmount, double discountAmount,
      BuildContext context);


}