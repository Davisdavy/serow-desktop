
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';

abstract class PurchaseOrdersRepository {
  //Brands
  Future<List<PurchaseOrders>> getPurchaseOrderList(BuildContext context);
  Future<List<PurchaseOrders>> getMultiPurchaseOrderList(BuildContext context);
  Future<String> patchPurchaseOrder(PurchaseOrders result);
  Future<String> putPurchaseOrder(PurchaseOrders result);
  Future<String> deletedPurchaseOrder(String id, BuildContext context);
  Future postPurchaseOrder(String supplier, String branch,
      double tradeDiscountPercentage,
      Decimal totalAmount, Decimal discountAmount, String expectedDate,
      double totalNetAmount, Decimal taxAmount, List<Map<String, dynamic>> purchaseOrderItemList,
      BuildContext context);


}