
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/pos/quotation.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/quotation_repository.dart';
import 'package:serow/services/services.dart';
import 'dart:convert';

class QuotationPOSRepository implements QuotationRepository{
  @override
  Future<String> deletedQuotation(String id, BuildContext context) {
    // TODO: implement deletedSale
    throw UnimplementedError();
  }

  @override
  Future<List<Quotations>> getQuotationList(BuildContext context) {
    // TODO: implement getSaleList
    throw UnimplementedError();
  }

  @override
  Future<String> patchQuotation(Quotations sales) {
    // TODO: implement patchSale
    throw UnimplementedError();
  }

  @override
  Future<Quotations> postQuotation(String customer, String branch,
      double discountAmount, double discountPercentage, double totalNet, double vatAmount,
      double totalAmount, String item, double itemQty, double unitPrice,
      double bonus, double itemTotalQty, itemDiscPercentage, itemDiscAmount, double itemNetAmount,
      double itemVATPercentage, double itemVATAmount, double itemTotalAmount, BuildContext context) async{

    List<Map<String, dynamic>>quotationItemList = [
      {
        "item": item,
        "quantity": itemQty,
        "unit_cost": unitPrice,
        "bonus": bonus,
        "total_quantity": itemTotalQty,
        "discount_percentage": itemDiscPercentage,
        "discount_amount": itemDiscAmount,
        "net_amount": itemNetAmount,
        "vat_percentage": itemVATPercentage,
        "vat_amount": itemVATAmount,
        "total_amount": itemTotalAmount,
      }
    ];
    var body = {
      'customer': customer,
      'branch': branch,
      'discount_percentage':discountPercentage,
      'discount_amount': discountAmount,
      "expected_date": "2021-10-05",
      'total_net': totalNet,
      'vat_amount': vatAmount,
      'total_amount':totalAmount,
      'quotation_items': quotationItemList
    };

    print("Sales Body $body");
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.pos_quotations}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(body) ,
    );
    print('Post status code: ${response.statusCode} ');
    print('Post body: ${response.body}');

    return quotationsFromJson(response.body);
  }

  @override
  Future<String> putQuotation(Quotations sales) {
    // TODO: implement putSale
    throw UnimplementedError();
  }
}