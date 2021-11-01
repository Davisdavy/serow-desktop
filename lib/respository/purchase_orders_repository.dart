
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';

abstract class PurchaseOrdersRepository {
  //Brands
  Future<List<Results>> getPurchaseOrderList(BuildContext context);
  Future<String> patchPurchaseOrder(Results result);
  Future<String> putPurchaseOrder(Results result);
  Future<Results> deletedPurchaseOrder(String id, BuildContext context);
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch,List<String>purchase_order_items, BuildContext context);


}