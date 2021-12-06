import 'package:flutter/material.dart';
import 'package:serow/models/pos/quotation.dart';
import 'package:serow/repository/quotation_repository.dart';


class QuotationController{
  final QuotationRepository _repository;
  QuotationController(this._repository);

//get
  Future<List<Quotations> >fetchQuotationList(BuildContext context){
    return _repository.getQuotationList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Quotations quotations) async{
    return _repository.patchQuotation(quotations);
  }

  //put
  Future<String >updatePutCompleted(Quotations quotations) async{
    return _repository.putQuotation(quotations);
  }

  //delete
  Future<String>deleteQuotation(String id, BuildContext context) async{
    return _repository.deletedQuotation(id, context);
  }

  //delete
  Future<Quotations>postSales(String customer, String branch,
      double discountAmount, double totalNet, double vatAmount, double totalAmount, double discountPercentage,
      String item, double itemQty, double unitPrice, double bonus,
      double itemTotalQty, itemDiscPercentage, itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount,
      double itemTotalAmount, BuildContext context) async{
    return _repository.postQuotation(customer, branch,
        discountAmount, discountPercentage,totalNet, vatAmount, totalAmount, item, itemQty, unitPrice, bonus, itemTotalQty, itemDiscPercentage, itemDiscAmount,
        itemNetAmount, itemVATPercentage, itemVATAmount, itemTotalAmount, context
    );
  }
}