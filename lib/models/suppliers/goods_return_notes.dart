

import 'dart:convert';

GoodsReturnNotes goodsReturnNotesFromJson(String str) => GoodsReturnNotes.fromJson(json.decode(str));
class GoodsReturnNotes {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  GoodsReturnNotes({this.count, this.next, this.previous, this.results});

  GoodsReturnNotes.fromJson(Map<String, dynamic> json) {
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
  List<GoodsReturnNoteItems> goodsReturnNoteItems;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String code;
  int tradeDiscountPercentage;
  String paymentDate;
  int discountAmount;
  int totalNet;
  int taxAmount;
  int totalAmount;
  int noOfItems;
  Null notes;
  String status;
  String supplier;
  String branch;
  String company;

  Results(
      {this.id,
        this.goodsReturnNoteItems,
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
        this.status,
        this.supplier,
        this.branch,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['goods_return_note_items'] != null) {
      goodsReturnNoteItems = new List<GoodsReturnNoteItems>();
      json['goods_return_note_items'].forEach((v) {
        goodsReturnNoteItems.add(new GoodsReturnNoteItems.fromJson(v));
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
    status = json['status'];
    supplier = json['supplier'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.goodsReturnNoteItems != null) {
      data['goods_return_note_items'] =
          this.goodsReturnNoteItems.map((v) => v.toJson()).toList();
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
    data['status'] = this.status;
    data['supplier'] = this.supplier;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class GoodsReturnNoteItems {
  String id;
  String goodsReturnNote;
  List<GoodsReturnNoteItemDetails> goodsReturnNoteItemDetails;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  int quantity;
  int unitCost;
  int bonus;
  int totalQuantity;
  int discountPercentage;
  int discountAmount;
  int netAmount;
  int taxPercentage;
  int taxAmount;
  int totalCost;
  String item;
  String branch;
  String company;

  GoodsReturnNoteItems(
      {this.id,
        this.goodsReturnNote,
        this.goodsReturnNoteItemDetails,
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

  GoodsReturnNoteItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsReturnNote = json['goods_return_note'];
    if (json['goods_return_note_item_details'] != null) {
      goodsReturnNoteItemDetails = new List<GoodsReturnNoteItemDetails>();
      json['goods_return_note_item_details'].forEach((v) {
        goodsReturnNoteItemDetails
            .add(new GoodsReturnNoteItemDetails.fromJson(v));
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
    data['goods_return_note'] = this.goodsReturnNote;
    if (this.goodsReturnNoteItemDetails != null) {
      data['goods_return_note_item_details'] =
          this.goodsReturnNoteItemDetails.map((v) => v.toJson()).toList();
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

class GoodsReturnNoteItemDetails {
  String id;
  String goodsReturnNoteItem;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  int quantity;
  String expiryDate;
  String batchNumber;
  String location;
  String branch;
  String company;

  GoodsReturnNoteItemDetails(
      {this.id,
        this.goodsReturnNoteItem,
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

  GoodsReturnNoteItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsReturnNoteItem = json['goods_return_note_item'];
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
    data['goods_return_note_item'] = this.goodsReturnNoteItem;
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