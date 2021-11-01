
import 'dart:convert';

GoodsReceivedNotes goodsReceivedNotesFromJson(String str) => GoodsReceivedNotes.fromJson(json.decode(str));
class GoodsReceivedNotes {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  GoodsReceivedNotes({this.count, this.next, this.previous, this.results});

  GoodsReceivedNotes.fromJson(Map<String, dynamic> json) {
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
  List<GrnItems> grnItems;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String code;
  dynamic tradeDiscountPercentage;
  Null paymentDate;
  dynamic discountAmount;
  dynamic totalNet;
  dynamic taxAmount;
  dynamic totalAmount;
  dynamic noOfItems;
  Null notes;
  String grnType;
  String supplier;
  Null purchaseOrder;
  String branch;
  String company;

  Results(
      {this.id,
        this.grnItems,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.tradeDiscountPercentage,
        this.paymentDate,
        this.discountAmount,
        this.totalNet,
        this.taxAmount,
        this.totalAmount,
        this.noOfItems,
        this.notes,
        this.grnType,
        this.supplier,
        this.purchaseOrder,
        this.branch,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['grn_items'] != null) {
      grnItems = new List<GrnItems>();
      json['grn_items'].forEach((v) {
        grnItems.add(new GrnItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    tradeDiscountPercentage = json['trade_discount_percentage'];
    paymentDate = json['payment_date'];
    discountAmount = json['discount_amount'];
    totalNet = json['total_net'];
    taxAmount = json['tax_amount'];
    totalAmount = json['total_amount'];
    noOfItems = json['no_of_items'];
    notes = json['notes'];
    grnType = json['grn_type'];
    supplier = json['supplier'];
    purchaseOrder = json['purchase_order'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.grnItems != null) {
      data['grn_items'] = this.grnItems.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['trade_discount_percentage'] = this.tradeDiscountPercentage;
    data['payment_date'] = this.paymentDate;
    data['discount_amount'] = this.discountAmount;
    data['total_net'] = this.totalNet;
    data['tax_amount'] = this.taxAmount;
    data['total_amount'] = this.totalAmount;
    data['no_of_items'] = this.noOfItems;
    data['notes'] = this.notes;
    data['grn_type'] = this.grnType;
    data['supplier'] = this.supplier;
    data['purchase_order'] = this.purchaseOrder;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class GrnItems {
  String id;
  String grn;
  List<GrnItemDetails> grnItemDetails;
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
  dynamic taxAmount;
  dynamic totalCost;
  String item;
  String branch;
  String company;

  GrnItems(
      {this.id,
        this.grn,
        this.grnItemDetails,
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
        this.branch,
        this.company});

  GrnItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grn = json['grn'];
    if (json['grn_item_details'] != null) {
      grnItemDetails = new List<GrnItemDetails>();
      json['grn_item_details'].forEach((v) {
        grnItemDetails.add(new GrnItemDetails.fromJson(v));
      });
    }
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
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grn'] = this.grn;
    if (this.grnItemDetails != null) {
      data['grn_item_details'] =
          this.grnItemDetails.map((v) => v.toJson()).toList();
    }
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
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class GrnItemDetails {
  String id;
  String grnItem;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  dynamic quantity;
  String expiryDate;
  String batchNumber;
  String location;
  String branch;
  String company;

  GrnItemDetails(
      {this.id,
        this.grnItem,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.quantity,
        this.expiryDate,
        this.batchNumber,
        this.location,
        this.branch,
        this.company});

  GrnItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grnItem = json['grn_item'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    quantity = json['quantity'];
    expiryDate = json['expiry_date'];
    batchNumber = json['batch_number'];
    location = json['location'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grn_item'] = this.grnItem;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['quantity'] = this.quantity;
    data['expiry_date'] = this.expiryDate;
    data['batch_number'] = this.batchNumber;
    data['location'] = this.location;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}