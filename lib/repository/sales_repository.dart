
import 'package:flutter/material.dart';
import 'package:serow/models/pos/sales.dart';

abstract class SalesRepository {

  Future<List<Sales>> getSaleList(BuildContext context);

  Future<String> patchSale(Sales sales);

  Future<String> putSale(Sales sales);

  Future<String> deletedSale(String id, BuildContext context);

  Future<Sales> postSale(String customer, String branch,
      String status, double discountAmount, double totalNet,
  double vatAmount, double totalAmount, String item, double itemQty,
      double unitPrice, double bonus, double itemTotalQty, itemDiscPercentage, itemDiscAmount ,
      double itemNetAmount, double itemVATPercentage, double itemVATAmount,
       double itemTotalAmount,
      BuildContext context);

}