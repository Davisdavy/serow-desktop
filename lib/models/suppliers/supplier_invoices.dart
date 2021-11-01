import 'dart:convert';

SupplierInvoices supplierInvoicesFromJson(String str) => SupplierInvoices.fromJson(json.decode(str));
class SupplierInvoices {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  SupplierInvoices({this.count, this.next, this.previous, this.results});

  SupplierInvoices.fromJson(Map<String, dynamic> json) {
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
  List<SupplierInvoiceItems> supplierInvoiceItems;
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
  String receivedDate;
  String postedAt;
  String status;
  String supplier;
  String branch;
  String company;

  Results(
      {this.id,
        this.supplierInvoiceItems,
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
        this.receivedDate,
        this.postedAt,
        this.status,
        this.supplier,
        this.branch,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['supplier_invoice_items'] != null) {
      supplierInvoiceItems = new List<SupplierInvoiceItems>();
      json['supplier_invoice_items'].forEach((v) {
        supplierInvoiceItems.add(new SupplierInvoiceItems.fromJson(v));
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
    receivedDate = json['received_date'];
    postedAt = json['posted_at'];
    status = json['status'];
    supplier = json['supplier'];
    branch = json['branch'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.supplierInvoiceItems != null) {
      data['supplier_invoice_items'] =
          this.supplierInvoiceItems.map((v) => v.toJson()).toList();
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
    data['received_date'] = this.receivedDate;
    data['posted_at'] = this.postedAt;
    data['status'] = this.status;
    data['supplier'] = this.supplier;
    data['branch'] = this.branch;
    data['company'] = this.company;
    return data;
  }
}

class SupplierInvoiceItems {
  String id;
  String supplierInvoice;
  List<SupplierInvoiceItemDetails> supplierInvoiceItemDetails;
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

  SupplierInvoiceItems(
      {this.id,
        this.supplierInvoice,
        this.supplierInvoiceItemDetails,
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

  SupplierInvoiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierInvoice = json['supplier_invoice'];
    if (json['supplier_invoice_item_details'] != null) {
      supplierInvoiceItemDetails = new List<SupplierInvoiceItemDetails>();
      json['supplier_invoice_item_details'].forEach((v) {
        supplierInvoiceItemDetails
            .add(new SupplierInvoiceItemDetails.fromJson(v));
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
    data['supplier_invoice'] = this.supplierInvoice;
    if (this.supplierInvoiceItemDetails != null) {
      data['supplier_invoice_item_details'] =
          this.supplierInvoiceItemDetails.map((v) => v.toJson()).toList();
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

class SupplierInvoiceItemDetails {
  String id;
  String supplierInvoiceItem;
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

  SupplierInvoiceItemDetails(
      {this.id,
        this.supplierInvoiceItem,
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

  SupplierInvoiceItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierInvoiceItem = json['supplier_invoice_item'];
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
    data['supplier_invoice_item'] = this.supplierInvoiceItem;
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