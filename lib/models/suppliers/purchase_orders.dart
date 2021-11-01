
import 'dart:convert';

PurchaseOrders purchaseOrdersFromJson(String str) => PurchaseOrders.fromJson(json.decode(str));
class PurchaseOrders {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  PurchaseOrders({this.count, this.next, this.previous, this.results});

  PurchaseOrders.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  List<PurchaseOrderItems> purchaseOrderItems;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String code;
  dynamic tradeDiscountPercentage;
  String expectedDate;
  dynamic discountAmount;
  dynamic totalNet;
  double taxAmount;
  double totalAmount;
  dynamic noOfItems;
  Null notes;
  String purchaseStatus;
  String supplier;
  String branch;
  String company;

  Results(
      {this.id,
        this.purchaseOrderItems,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.tradeDiscountPercentage,
        this.expectedDate,
        this.discountAmount,
        this.totalNet,
        this.taxAmount,
        this.totalAmount,
        this.noOfItems,
        this.notes,
        this.purchaseStatus,
        this.supplier,
        this.branch,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['purchase_order_items'] != null) {
      purchaseOrderItems = new List<PurchaseOrderItems>();
      json['purchase_order_items'].forEach((v) {
        purchaseOrderItems.add(new PurchaseOrderItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    tradeDiscountPercentage = json['trade_discount_percentage'];
    expectedDate = json['expected_date'];
    discountAmount = json['discount_amount'];
    totalNet = json['total_net'];
    taxAmount = json['tax_amount'];
    totalAmount = json['total_amount'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    purchaseStatus = json['purchase_status'];
    supplier = json['supplier'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.purchaseOrderItems != null) {
      data['purchase_order_items'] =
          this.purchaseOrderItems.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['trade_discount_percentage'] = this.tradeDiscountPercentage;
    data['expected_date'] = this.expectedDate;
    data['discount_amount'] = this.discountAmount;
    data['total_net'] = this.totalNet;
    data['tax_amount'] = this.taxAmount;
    data['total_amount'] = this.totalAmount;
    data['no_of_items'] = this.noOfItems;
    data['notes'] = this.notes;
    data['purchase_status'] = this.purchaseStatus;
    data['supplier'] = this.supplier;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class PurchaseOrderItems {
  String id;
  String purchaseOrder;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  dynamic quantity;
  dynamic unitCost;
  dynamic bonus;
  dynamic totalQuantity;
  dynamic discountPercentage;
  dynamic discountAmount;
  dynamic netAmount;
  dynamic taxPercentage;
  double taxAmount;
  double totalCost;
  String item;
  String company;

  PurchaseOrderItems(
      {this.id,
        this.purchaseOrder,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.quantity,
        this.unitCost,
        this.bonus,
        this.totalQuantity,
        this.discountPercentage,
        this.discountAmount,
        this.netAmount,
        this.taxPercentage,
        this.taxAmount,
        this.totalCost,
        this.item,
        this.company});

  PurchaseOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseOrder = json['purchase_order'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    quantity = json['quantity'];
    unitCost = json['unit_cost'];
    bonus = json['bonus'];
    totalQuantity = json['total_quantity'];
    discountPercentage = json['discount_percentage'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    totalCost = json['total_cost'];
    item = json['item'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_order'] = this.purchaseOrder;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['quantity'] = this.quantity;
    data['unit_cost'] = this.unitCost;
    data['bonus'] = this.bonus;
    data['total_quantity'] = this.totalQuantity;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['net_amount'] = this.netAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_amount'] = this.taxAmount;
    data['total_cost'] = this.totalCost;
    data['item'] = this.item;
    data['company'] = this.company;
    return data;
  }
}