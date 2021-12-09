import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/supplier_invoices_repository.dart';
import 'package:serow/services/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupplierInvoicesSupplierRepository implements SupplierInvoicesRepository {
  @override
  Future<String> deletedSupplierInvoice(String id, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final http.Response response =
        await http.delete(Uri.parse('${AppUrl.supplier_invoices}$id/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${user.accessToken.toString()}",
    });

    return json.decode(json.encode(response.body));
  }

  @override
  Future<List<SupplierInvoices>> getSupplierInvoiceList(BuildContext context) async{
    //https://serow.herrings.co.ke/api/v1/suppliers/purchase-orders/
    List<SupplierInvoices> subgroupList = [];
    context.watch<AuthProvider>();
    Auth user = Provider.of<AuthProvider>(context).auth;

    var response = await http.get(Uri.parse('${AppUrl.supplier_invoices}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization":
      "Bearer ${user.accessToken.toString()}"
    }, );
    print('Get supplier invoices status code: ${response.statusCode}');
    if(response.statusCode == 200) {
      var body = json.decode(response.body); //convert
      //parse
      print('Result body: ${body['results']}');
      for (Map<String, dynamic> i in body["results"]) {
        subgroupList.add(SupplierInvoices.fromJson(i));
      }
    } else if(response.statusCode == 401){
      //refresh token and call getUser again
      final response =  await http.get(Uri.parse('${AppUrl.supplier_invoices}'),
          headers: {'grant_type': 'refresh_token', 'refresh_token': '${user.refreshToken}'});
      var body = json.decode(response.body);
      for (Map<String, dynamic> i in body["results"]) {
        subgroupList.add(SupplierInvoices.fromJson(i));
      }
      // token = jsonDecode(response.body)['token'];
      // refresh_token = jsonDecode(response.body)['refresh_token'];
      // return getUser();
    }
    return subgroupList;
  }

  @override
  Future<String> patchSupplierInvoice(SupplierInvoices result) {
    // TODO: implement patchPurchaseOrder
    throw UnimplementedError();
  }

  @override
  Future<SupplierInvoices> postSupplierInvoice(String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate, double discountAmount,
      double totalNet, double vatAmount, double totalAmount, String status,
      String item, double itemQty,
      double unitPrice, double bonus,
      double itemTotalQty, String expiryDate, String batchNo, double itemDiscPercentage, double itemDiscAmount,
      double itemNetAmount, double itemVATPercentage,
      double itemVATAmount, double totalCost,
      double itemTotalAmount, BuildContext context) async{
    ;
    List<Map<String, dynamic>>supplierInvoiceItemList = [
      {
        "item": item,
        "quantity": itemQty,
        "unit_cost": unitPrice,
        "bonus": bonus,
        "total_quantity": itemTotalQty,
        'expiry_date':'2022-10-05',
        'batch_number': batchNo,
        "discount_percentage": itemDiscPercentage,
        "discount_amount": itemDiscAmount,
        "net_amount": itemNetAmount,
        "vat_percentage": itemVATPercentage,
        "vat_amount": itemVATAmount,
        "total_amount": itemTotalAmount,
      }
    ];
    var body = {
      'supplier': supplier,
      'branch': branch,
      'purchase_order': purchaseOrderId,
      'trade_discount_percentage': tradeDiscPercentage,
      'discount_amount': discountAmount,
      'total_net': totalNet,
      'received_date': receivedDate,
      'vat_amount': vatAmount,
      'status': 'posted',
      'total_amount':totalAmount,

      'supplier_invoice_items': supplierInvoiceItemList
    };
    print("Post: $body");
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.supplier_invoices}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(body) ,
    );

    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return SupplierInvoices.fromJson(response.body as Map);
  }

  @override
  Future<String> putSupplierInvoice(SupplierInvoices result) {
    // TODO: implement putPurchaseOrder
    throw UnimplementedError();
  }

  @override
  Future<SupplierInvoices> postNewSupplierInvoice(String supplier, String branch,
      String purchaseOrderId, double tradeDiscPercentage, String receivedDate,
      double discountAmount, double totalNet, double vatAmount,
      double totalAmount, String status, List<Map<String, dynamic>> listItems,
      BuildContext context) async{
    var body = {
      'supplier': supplier,
      'branch': branch,
      'purchase_order': purchaseOrderId,
      'trade_discount_percentage': tradeDiscPercentage,
      'discount_amount': discountAmount,
      'total_net': totalNet,
      'received_date': receivedDate,
      'vat_amount': vatAmount,
      'status': 'posted',
      'total_amount':totalAmount,
      'supplier_invoice_items': listItems
    };
    print("Post: $body");
    Auth user = Provider.of<AuthProvider>(context,listen: false).auth;
    var response = await http.post(Uri.parse('${AppUrl.supplier_invoices}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
      body: jsonEncode(body) ,
    );

    print('Post status code: ${response.statusCode}');
    print('Post body: ${response.body}');
    // print('Post toJSON: ${br}');
    return SupplierInvoices.fromJson(response.body as Map);
  }


}
