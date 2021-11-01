
import 'dart:convert';

Suppliers suppliersFromJson(String str) => Suppliers.fromJson(json.decode(str));
class Suppliers {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Suppliers({this.count, this.next, this.previous, this.results});

  Suppliers.fromJson(Map<String, dynamic> json) {
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
  List<SupplierContacts> supplierContacts;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String code;
  String name;
  Null logo;
  String description;
  String email;
  String physicalAddress;
  String phoneCountryCode;
  String phone;
  dynamic creditLimit;
  Null lastPayDate;
  dynamic lastPayAmount;
  dynamic balance;
  dynamic totalPurchases;
  String pinNo;
  String vatNo;
  bool useLocalCurrency;
  String currency;
  String postingCategory;
  String company;

  Results(
      {this.id,
        this.supplierContacts,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.name,
        this.logo,
        this.description,
        this.email,
        this.physicalAddress,
        this.phoneCountryCode,
        this.phone,
        this.creditLimit,
        this.lastPayDate,
        this.lastPayAmount,
        this.balance,
        this.totalPurchases,
        this.pinNo,
        this.vatNo,
        this.useLocalCurrency,
        this.currency,
        this.postingCategory,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['supplier_contacts'] != null) {
      supplierContacts = new List<SupplierContacts>();
      json['supplier_contacts'].forEach((v) {
        supplierContacts.add(new SupplierContacts.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    email = json['email'];
    physicalAddress = json['physical_address'];
    phoneCountryCode = json['phone_country_code'];
    phone = json['phone'];
    creditLimit = json['credit_limit'];
    lastPayDate = json['last_pay_date'];
    lastPayAmount = json['last_pay_amount'];
    balance = json['balance'];
    totalPurchases = json['total_purchases'];
    pinNo = json['pin_no'];
    vatNo = json['vat_no'];
    useLocalCurrency = json['use_local_currency'];
    currency = json['currency'];
    postingCategory = json['posting_category'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.supplierContacts != null) {
      data['supplier_contacts'] =
          this.supplierContacts.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['email'] = this.email;
    data['physical_address'] = this.physicalAddress;
    data['phone_country_code'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['credit_limit'] = this.creditLimit;
    data['last_pay_date'] = this.lastPayDate;
    data['last_pay_amount'] = this.lastPayAmount;
    data['balance'] = this.balance;
    data['total_purchases'] = this.totalPurchases;
    data['pin_no'] = this.pinNo;
    data['vat_no'] = this.vatNo;
    data['use_local_currency'] = this.useLocalCurrency;
    data['currency'] = this.currency;
    data['posting_category'] = this.postingCategory;
    data['company'] = this.company;
    return data;
  }
}

class SupplierContacts {
  String id;
  String supplier;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String physicalAddress;
  String email;
  String phone;
  String company;

  SupplierContacts(
      {this.id,
        this.supplier,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.physicalAddress,
        this.email,
        this.phone,
        this.company});

  SupplierContacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplier = json['supplier'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    physicalAddress = json['physical_address'];
    email = json['email'];
    phone = json['phone'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier'] = this.supplier;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['physical_address'] = this.physicalAddress;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company'] = this.company;
    return data;
  }
}