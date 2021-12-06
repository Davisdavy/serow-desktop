// To parse this JSON data, do
//
//     final suppliers = suppliersFromJson(jsonString);

import 'dart:convert';

Suppliers suppliersFromJson(String str) => Suppliers.fromJson(json.decode(str));

String suppliersToJson(Suppliers data) => json.encode(data.toJson());

class Suppliers {
  Suppliers({
    this.id,
    this.supplierContacts,
    this.postingCategory,
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
    this.company,
  });

  String id;
  List<SupplierContact> supplierContacts;
  PostingCategory postingCategory;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  dynamic logo;
  String description;
  String email;
  String physicalAddress;
  String phoneCountryCode;
  String phone;
  double creditLimit;
  dynamic lastPayDate;
  double lastPayAmount;
  double balance;
  double totalPurchases;
  String pinNo;
  String vatNo;
  bool useLocalCurrency;
  String currency;
  String company;

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
    id: json["id"],
    supplierContacts: List<SupplierContact>.from(json["supplier_contacts"].map((x) => SupplierContact.fromJson(x))),
    postingCategory: PostingCategory.fromJson(json["posting_category"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    email: json["email"],
    physicalAddress: json["physical_address"],
    phoneCountryCode: json["phone_country_code"],
    phone: json["phone"],
    creditLimit: json["credit_limit"],
    lastPayDate: json["last_pay_date"],
    lastPayAmount: json["last_pay_amount"],
    balance: json["balance"],
    totalPurchases: json["total_purchases"],
    pinNo: json["pin_no"],
    vatNo: json["vat_no"],
    useLocalCurrency: json["use_local_currency"],
    currency: json["currency"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplier_contacts": List<dynamic>.from(supplierContacts.map((x) => x.toJson())),
    "posting_category": postingCategory.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "code": code,
    "name": name,
    "logo": logo,
    "description": description,
    "email": email,
    "physical_address": physicalAddress,
    "phone_country_code": phoneCountryCode,
    "phone": phone,
    "credit_limit": creditLimit,
    "last_pay_date": lastPayDate,
    "last_pay_amount": lastPayAmount,
    "balance": balance,
    "total_purchases": totalPurchases,
    "pin_no": pinNo,
    "vat_no": vatNo,
    "use_local_currency": useLocalCurrency,
    "currency": currency,
    "company": company,
  };
}

class PostingCategory {
  PostingCategory({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.code,
    this.name,
    this.account,
    this.company,
  });

  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  String account;
  String company;

  factory PostingCategory.fromJson(Map<String, dynamic> json) => PostingCategory(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    name: json["name"],
    account: json["account"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "code": code,
    "name": name,
    "account": account,
    "company": company,
  };
}

class SupplierContact {
  SupplierContact({
    this.id,
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
    this.company,
  });

  String id;
  String supplier;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String physicalAddress;
  String email;
  String phone;
  String company;

  factory SupplierContact.fromJson(Map<String, dynamic> json) => SupplierContact(
    id: json["id"],
    supplier: json["supplier"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    physicalAddress: json["physical_address"],
    email: json["email"],
    phone: json["phone"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplier": supplier,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "name": name,
    "physical_address": physicalAddress,
    "email": email,
    "phone": phone,
    "company": company,
  };
}
