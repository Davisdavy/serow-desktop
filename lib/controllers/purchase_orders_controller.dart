
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';
import 'package:serow/repository/purchase_orders_repository.dart';

class PurchaseOrdersController {
  final PurchaseOrdersRepository _repository;
  PurchaseOrdersController(this._repository);
//get
  Future<List<Results>> fetchPurchaseOrderList(BuildContext context) {
    return _repository.getPurchaseOrderList(context);
  }

  //patch
  Future<String> updatePatchCompleted(Results result) async {
    return _repository.patchPurchaseOrder(result);
  }

  //put
  Future<String> updatePutCompleted(Results result) async {
    return _repository.putPurchaseOrder(result);
  }

  //delete
  Future<String> deletePurchaseOrder(String id, BuildContext context) async {
    return _repository.deletedPurchaseOrder(id, context);
  }

  //delete
  Future<PurchaseOrders> postPurchaseOrder(String supplier, String branch,
      List<dynamic> purchase_order_items, BuildContext context) async {
    return _repository.postPurchaseOrder(
        supplier, branch, purchase_order_items, context);
  }
}
