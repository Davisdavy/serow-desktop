// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';


class Customers {
  Customers({
    this.id,
    this.category,
    this.billingAddress,
    this.shippingAddress,
    this.customerContacts,
    this.loyaltyPoints,
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
    this.phone,
    this.enforcePaymentTerms,
    this.isLoyaltyMember,
    this.okToEmail,
    this.okToSms,
    this.micropayBalance,
    this.creditLimit,
    this.balance,
    this.totalRevenue,
    this.salesMargin,
    this.type,
    this.postingCategory,
    this.paymentTerms,
    this.branch,
    this.company,
  });

  String id;
  Category category;
  BillingAddress billingAddress;
  BillingAddress shippingAddress;
  List<CustomerContact> customerContacts;
  BillingAddress loyaltyPoints;
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
  String phone;
  bool enforcePaymentTerms;
  bool isLoyaltyMember;
  bool okToEmail;
  bool okToSms;
  double micropayBalance;
  double creditLimit;
  double balance;
  double totalRevenue;
  double salesMargin;
  String type;
  String postingCategory;
  String paymentTerms;
  String branch;
  String company;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
    id: json["id"],
    category: Category.fromJson(json["category"]),
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
    shippingAddress: BillingAddress.fromJson(json["shipping_address"]),
    customerContacts: List<CustomerContact>.from(json["customer_contacts"].map((x) => CustomerContact.fromJson(x))),
    loyaltyPoints: BillingAddress.fromJson(json["loyalty_points"]),
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
    phone: json["phone"],
    enforcePaymentTerms: json["enforce_payment_terms"],
    isLoyaltyMember: json["is_loyalty_member"],
    okToEmail: json["ok_to_email"],
    okToSms: json["ok_to_sms"],
    micropayBalance: json["micropay_balance"],
    creditLimit: json["credit_limit"],
    balance: json["balance"],
    totalRevenue: json["total_revenue"],
    salesMargin: json["sales_margin"],
    type: json["type"],
    postingCategory: json["posting_category"],
    paymentTerms: json["payment_terms"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category.toJson(),
    "billing_address": billingAddress.toJson(),
    "shipping_address": shippingAddress.toJson(),
    "customer_contacts": List<dynamic>.from(customerContacts.map((x) => x.toJson())),
    "loyalty_points": loyaltyPoints.toJson(),
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
    "phone": phone,
    "enforce_payment_terms": enforcePaymentTerms,
    "is_loyalty_member": isLoyaltyMember,
    "ok_to_email": okToEmail,
    "ok_to_sms": okToSms,
    "micropay_balance": micropayBalance,
    "credit_limit": creditLimit,
    "balance": balance,
    "total_revenue": totalRevenue,
    "sales_margin": salesMargin,
    "type": type,
    "posting_category": postingCategory,
    "payment_terms": paymentTerms,
    "branch": branch,
    "company": company,
  };
}

class BillingAddress {
  BillingAddress();

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Category {
  Category({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.name,
    this.isOrganization,
    this.company,
  });

  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  bool isOrganization;
  String company;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    isOrganization: json["is_organization"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "name": name,
    "is_organization": isOrganization,
    "company": company,
  };
}

class CustomerContact {
  CustomerContact({
    this.id,
    this.customer,
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
  String customer;
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

  factory CustomerContact.fromJson(Map<String, dynamic> json) => CustomerContact(
    id: json["id"],
    customer: json["customer"],
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
    "customer": customer,
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
