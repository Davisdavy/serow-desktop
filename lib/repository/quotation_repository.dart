
import 'package:flutter/material.dart';
import 'package:serow/models/pos/quotation.dart';

abstract class QuotationRepository {

  Future<List<Quotations>> getQuotationList(BuildContext context);

  Future<String> patchQuotation(Quotations sales);

  Future<String> putQuotation(Quotations sales);

  Future<String> deletedQuotation(String id, BuildContext context);

  Future<Quotations> postQuotation(String customer, String branch, double discountPercentage,
      double discountAmount, double totalNet,
      double vatAmount, double totalAmount, String item, double itemQty,
      double unitPrice, double bonus, double itemTotalQty, itemDiscPercentage, itemDiscAmount ,
      double itemNetAmount, double itemVATPercentage, double itemVATAmount,
      double itemTotalAmount,
      BuildContext context);

}