
import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/pos/sales.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/sales_repository.dart';
import 'package:http/http.dart' as http;
import 'package:serow/services/services.dart';

class SalesPOSRepository implements SalesRepository{
  @override
  Future<String> deletedSale(String id, BuildContext context) {
    // TODO: implement deletedSale
    throw UnimplementedError();
  }

  @override
  Future<List<Sales>> getSaleList(BuildContext context) {
    // TODO: implement getSaleList
    throw UnimplementedError();
  }

  @override
  Future<String> patchSale(Sales sales) {
    // TODO: implement patchSale
    throw UnimplementedError();
  }


  @override
  Future<String> putSale(Sales sales) {
    // TODO: implement putSale
    throw UnimplementedError();
  }

  @override
  Future<Sales> postSale(String customer, String branch, String status,
       double discountAmount,
      double totalNet, double vatAmount, double totalAmount,
      String item, double itemQty,
       double unitPrice, double bonus,
      double itemTotalQty, itemDiscPercentage, itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount,
      double itemTotalAmount, BuildContext context) async {

    List<Map<String, dynamic>>saleItemList = [
      {
        "item": item,
        "quantity": itemQty,
        "unit_price": unitPrice,
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
      'discount_percentage':0.0,
      'discount_amount': discountAmount,
      'total_net': totalNet,
      'vat_amount': vatAmount,
      'total_amount':totalAmount,
      'status': status,
      'sale_items': saleItemList
    };

    print("Sales Body $body");
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.pos_sales}'),
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



    //var encode = json.encode(responsebody) as Map<String, dynamic>;

    return Sales.fromJson(response.body);
  }
}