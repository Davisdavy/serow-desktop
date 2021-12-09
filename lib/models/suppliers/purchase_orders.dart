// To parse this JSON data, do
//
//     final purchaseOrders = purchaseOrdersFromJson(jsonString);

import 'dart:convert';

PurchaseOrders purchaseOrdersFromJson(String str) => PurchaseOrders.fromJson(json.decode(str));

String purchaseOrdersToJson(PurchaseOrders data) => json.encode(data.toJson());

class PurchaseOrders {
  PurchaseOrders({
    this.id,
    this.purchaseOrderItems,
    this.supplier,
    this.branch,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.code,
    this.tradeDiscountPercentage,
    this.discountAmount,
    this.totalNet,
    this.vatAmount,
    this.totalCost,
    this.totalAmount,
    this.noOfItems,
    this.notes,
    this.purchaseStatus,
    this.company,
  });

  String id;
  List<PurchaseOrderItem> purchaseOrderItems;
  Supplier supplier;
  Branch branch;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double tradeDiscountPercentage;
  double discountAmount;
  double totalNet;
  double vatAmount;
  double totalCost;
  double totalAmount;
  int noOfItems;
  dynamic notes;
  String purchaseStatus;
  String company;

  factory PurchaseOrders.fromJson(Map<String, dynamic> json) => PurchaseOrders(
    id: json["id"],
    purchaseOrderItems: List<PurchaseOrderItem>.from(json["purchase_order_items"].map((x) => PurchaseOrderItem.fromJson(x))),
    supplier: Supplier.fromJson(json["supplier"]),
    branch: Branch.fromJson(json["branch"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    tradeDiscountPercentage: json["trade_discount_percentage"],
    discountAmount: json["discount_amount"],
    totalNet: json["total_net"],
    vatAmount: json["vat_amount"].toDouble(),
    totalCost: json["total_cost"],
    totalAmount: json["total_amount"].toDouble(),
    noOfItems: json["no_of_items"],
    notes: json["notes"],
    purchaseStatus: json["purchase_status"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "purchase_order_items": List<dynamic>.from(purchaseOrderItems.map((x) => x.toJson())),
    "supplier": supplier.toJson(),
    "branch": branch.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "code": code,
    "trade_discount_percentage": tradeDiscountPercentage,
    "discount_amount": discountAmount,
    "total_net": totalNet,
    "vat_amount": vatAmount,
    "total_cost": totalCost,
    "total_amount": totalAmount,
    "no_of_items": noOfItems,
    "notes": notes,
    "purchase_status": purchaseStatus,
    "company": company,
  };
}

class Branch {
  Branch({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.name,
    this.description,
    this.email,
    this.location,
    this.phone,
    this.isHead,
    this.region,
    this.costCentre,
    this.company,
  });

  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String description;
  String email;
  String location;
  String phone;
  bool isHead;
  dynamic region;
  String costCentre;
  String company;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    description: json["description"],
    email: json["email"],
    location: json["location"],
    phone: json["phone"],
    isHead: json["is_head"],
    region: json["region"],
    costCentre: json["cost_centre"],
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
    "description": description,
    "email": email,
    "location": location,
    "phone": phone,
    "is_head": isHead,
    "region": region,
    "cost_centre": costCentre,
    "company": company,
  };
}

class PurchaseOrderItem {
  PurchaseOrderItem({
    this.id,
    this.item,
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
    this.vatPercentage,
    this.vatAmount,
    this.totalCost,
    this.totalAmount,
    this.purchaseOrder,
    this.branch,
    this.company,
  });

  String id;
  Item item;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  double unitCost;
  double bonus;
  double totalQuantity;
  double discountPercentage;
  double discountAmount;
  double netAmount;
  double vatPercentage;
  double vatAmount;
  double totalCost;
  double totalAmount;
  String purchaseOrder;
  dynamic branch;
  String company;

  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) => PurchaseOrderItem(
    id: json["id"],
    item: Item.fromJson(json["item"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    quantity: json["quantity"],
    unitCost: json["unit_cost"],
    bonus: json["bonus"],
    totalQuantity: json["total_quantity"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    netAmount: json["net_amount"],
    vatPercentage: json["vat_percentage"],
    vatAmount: json["vat_amount"].toDouble(),
    totalCost: json["total_cost"].toDouble(),
    totalAmount: json["total_amount"],
    purchaseOrder: json["purchase_order"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "quantity": quantity,
    "unit_cost": unitCost,
    "bonus": bonus,
    "total_quantity": totalQuantity,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "net_amount": netAmount,
    "vat_percentage": vatPercentage,
    "vat_amount": vatAmount,
    "total_cost": totalCost,
    "total_amount": totalAmount,
    "purchase_order": purchaseOrder,
    "branch": branch,
    "company": company,
  };
}

class Item {
  Item({
    this.id,
    this.group,
    this.subgroup,
    this.category,
    this.brand,
    this.itemForm,
    this.strength,
    this.pricing,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.no,
    this.code,
    this.name,
    this.slug,
    this.costPrice,
    this.avgCostPrice,
    this.tradePrice,
    this.retailPrice,
    this.minimumPrice,
    this.maximumPrice,
    this.wholesalePrice,
    this.minimumWholesalePrice,
    this.maximumWholesalePrice,
    this.supplierPrice,
    this.specialPrice,
    this.vatPercentage,
    this.usePricingFormula,
    this.image,
    this.barcode,
    this.packsize,
    this.description,
    this.availability,
    this.balance,
    this.usage,
    this.warnings,
    this.prescription,
    this.priority,
    this.sellingOptions,
    this.totalRevenue,
    this.totalPurchases,
    this.company,
  });

  String id;
  Category group;
  Category subgroup;
  Category category;
  PostingCategory brand;
  Category itemForm;
  Category strength;
  dynamic pricing;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  int no;
  String code;
  String name;
  String slug;
  double costPrice;
  double avgCostPrice;
  double tradePrice;
  double retailPrice;
  double minimumPrice;
  double maximumPrice;
  double wholesalePrice;
  double minimumWholesalePrice;
  double maximumWholesalePrice;
  double supplierPrice;
  double specialPrice;
  double vatPercentage;
  bool usePricingFormula;
  String image;
  dynamic barcode;
  int packsize;
  String description;
  String availability;
  double balance;
  String usage;
  dynamic warnings;
  bool prescription;
  int priority;
  String sellingOptions;
  double totalRevenue;
  double totalPurchases;
  String company;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    group: Category.fromJson(json["group"]),
    subgroup: Category.fromJson(json["subgroup"]),
    category: Category.fromJson(json["category"]),
    brand: PostingCategory.fromJson(json["brand"]),
    itemForm: Category.fromJson(json["item_form"]),
    strength: Category.fromJson(json["strength"]),
    pricing: json["pricing"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    no: json["no"],
    code: json["code"],
    name: json["name"],
    slug: json["slug"],
    costPrice: json["cost_price"],
    avgCostPrice: json["avg_cost_price"].toDouble(),
    tradePrice: json["trade_price"],
    retailPrice: json["retail_price"],
    minimumPrice: json["minimum_price"],
    maximumPrice: json["maximum_price"],
    wholesalePrice: json["wholesale_price"],
    minimumWholesalePrice: json["minimum_wholesale_price"],
    maximumWholesalePrice: json["maximum_wholesale_price"],
    supplierPrice: json["supplier_price"],
    specialPrice: json["special_price"],
    vatPercentage: json["vat_percentage"],
    usePricingFormula: json["use_pricing_formula"],
    image: json["image"],
    barcode: json["barcode"],
    packsize: json["packsize"],
    description: json["description"],
    availability: json["availability"],
    balance: json["balance"],
    usage: json["usage"],
    warnings: json["warnings"],
    prescription: json["prescription"],
    priority: json["priority"],
    sellingOptions: json["selling_options"],
    totalRevenue: json["total_revenue"],
    totalPurchases: json["total_purchases"].toDouble(),
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group": group.toJson(),
    "subgroup": subgroup.toJson(),
    "category": category.toJson(),
    "brand": brand.toJson(),
    "item_form": itemForm.toJson(),
    "strength": strength.toJson(),
    "pricing": pricing,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "no": no,
    "code": code,
    "name": name,
    "slug": slug,
    "cost_price": costPrice,
    "avg_cost_price": avgCostPrice,
    "trade_price": tradePrice,
    "retail_price": retailPrice,
    "minimum_price": minimumPrice,
    "maximum_price": maximumPrice,
    "wholesale_price": wholesalePrice,
    "minimum_wholesale_price": minimumWholesalePrice,
    "maximum_wholesale_price": maximumWholesalePrice,
    "supplier_price": supplierPrice,
    "special_price": specialPrice,
    "vat_percentage": vatPercentage,
    "use_pricing_formula": usePricingFormula,
    "image": image,
    "barcode": barcode,
    "packsize": packsize,
    "description": description,
    "availability": availability,
    "balance": balance,
    "usage": usage,
    "warnings": warnings,
    "prescription": prescription,
    "priority": priority,
    "selling_options": sellingOptions,
    "total_revenue": totalRevenue,
    "total_purchases": totalPurchases,
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
    this.name,
    this.shortName,
    this.country,
    this.company,
    this.code,
    this.account,
  });

  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String shortName;
  String country;
  String company;
  String code;
  String account;

  factory PostingCategory.fromJson(Map<String, dynamic> json) => PostingCategory(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    country: json["country"] == null ? null : json["country"],
    company: json["company"],
    code: json["code"] == null ? null : json["code"],
    account: json["account"] == null ? null : json["account"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "name": name,
    "short_name": shortName == null ? null : shortName,
    "country": country == null ? null : country,
    "company": company,
    "code": code == null ? null : code,
    "account": account == null ? null : account,
  };
}

class Category {
  Category({
    this.id,
    this.group,
    this.subgroup,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.name,
    this.slug,
    this.company,
    this.priority,
    this.shortName,
  });

  String id;
  dynamic group;
  Category subgroup;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String slug;
  String company;
  int priority;
  String shortName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    group: json["group"],
    subgroup: json["subgroup"] == null ? null : Category.fromJson(json["subgroup"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    company: json["company"],
    priority: json["priority"] == null ? null : json["priority"],
    shortName: json["short_name"] == null ? null : json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group": group,
    "subgroup": subgroup == null ? null : subgroup.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "name": name,
    "slug": slug == null ? null : slug,
    "company": company,
    "priority": priority == null ? null : priority,
    "short_name": shortName == null ? null : shortName,
  };
}

class Supplier {
  Supplier({
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

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
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
    balance: json["balance"].toDouble(),
    totalPurchases: json["total_purchases"].toDouble(),
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
