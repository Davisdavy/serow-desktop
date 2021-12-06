
import 'package:flutter/material.dart';
import 'package:serow/models/pos/sales.dart';
import 'package:serow/repository/sales_repository.dart';

class SalesController{
  final SalesRepository _repository;
  SalesController(this._repository);

  //get
  Future<List<Sales> >fetchSalesList(BuildContext context){
    return _repository.getSaleList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Sales sales) async{
    return _repository.patchSale(sales);
  }

  //put
  Future<String >updatePutCompleted(Sales sales) async{
    return _repository.putSale(sales);
  }

  //delete
  Future<String>deleteSales(String id, BuildContext context) async{
    return _repository.deletedSale(id, context);
  }

  //delete
  Future<Sales>postSales(String customer, String branch, String status,
      double discountAmount,
      double totalNet, double vatAmount, double totalAmount,
      String item, double itemQty, double unitPrice, double bonus,
      double itemTotalQty, itemDiscPercentage, itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount,
      double itemTotalAmount, BuildContext context) async{
    return _repository.postSale(customer, branch, status,
    discountAmount, totalNet, vatAmount, totalAmount, item, itemQty, unitPrice, bonus, itemTotalQty, itemDiscPercentage, itemDiscAmount,
      itemNetAmount, itemVATPercentage, itemVATAmount, itemTotalAmount, context
    );
  }
}