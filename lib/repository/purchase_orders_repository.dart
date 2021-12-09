
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';

abstract class PurchaseOrdersRepository {
  //Brands
  Future<List<PurchaseOrders>> getPurchaseOrderList(BuildContext context);
  Future<String> patchPurchaseOrder(PurchaseOrders result);
  Future<String> putPurchaseOrder(PurchaseOrders result);
  Future<String> deletedPurchaseOrder(String id, BuildContext context);
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch,
      double tradeDiscountPercentage,
      double totalAmount, double discountAmount, String expectedDate,
      double totalNetAmount, double taxAmount, List<Map<String, dynamic>> purchaseOrderItemList,
      BuildContext context);


}