// To parse this JSON data, do
//
//     final quotations = quotationsFromJson(jsonString);

import 'dart:convert';

Quotations quotationsFromJson(String str) => Quotations.fromJson(json.decode(str));

String quotationsToJson(Quotations data) => json.encode(data.toJson());

class Quotations {
  Quotations({
    this.id,
    this.quotationItems,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.code,
    this.discountPercentage,
    this.discountAmount,
    this.totalNet,
    this.vatAmount,
    this.totalCost,
    this.totalAmount,
    this.noOfItems,
    this.notes,
    this.customer,
    this.branch,
    this.company,
  });

  String id;
  List<QuotationItem> quotationItems;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  int discountPercentage;
  int discountAmount;
  int totalNet;
  double vatAmount;
  int totalCost;
  double totalAmount;
  int noOfItems;
  dynamic notes;
  String customer;
  String branch;
  String company;

  factory Quotations.fromJson(Map<String, dynamic> json) => Quotations(
    id: json["id"],
    quotationItems: List<QuotationItem>.from(json["quotation_items"].map((x) => QuotationItem.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    totalNet: json["total_net"],
    vatAmount: json["vat_amount"].toDouble(),
    totalCost: json["total_cost"],
    totalAmount: json["total_amount"].toDouble(),
    noOfItems: json["no_of_items"],
    notes: json["notes"],
    customer: json["customer"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quotation_items": List<dynamic>.from(quotationItems.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "code": code,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "total_net": totalNet,
    "vat_amount": vatAmount,
    "total_cost": totalCost,
    "total_amount": totalAmount,
    "no_of_items": noOfItems,
    "notes": notes,
    "customer": customer,
    "branch": branch,
    "company": company,
  };
}

class QuotationItem {
  QuotationItem({
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
    this.quotation,
    this.company,
    this.branch,
  });

  String id;
  Item item;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  int quantity;
  int unitCost;
  int bonus;
  int totalQuantity;
  int discountPercentage;
  int discountAmount;
  int netAmount;
  int vatPercentage;
  int vatAmount;
  int totalCost;
  int totalAmount;
  String quotation;
  String company;
  dynamic branch;

  factory QuotationItem.fromJson(Map<String, dynamic> json) => QuotationItem(
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
    vatAmount: json["vat_amount"],
    totalCost: json["total_cost"],
    totalAmount: json["total_amount"],
    quotation: json["quotation"],
    company: json["company"],
    branch: json["branch"],
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
    "quotation": quotation,
    "company": company,
    "branch": branch,
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
  Brand brand;
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
  int costPrice;
  double avgCostPrice;
  int tradePrice;
  int retailPrice;
  int minimumPrice;
  int maximumPrice;
  int wholesalePrice;
  int minimumWholesalePrice;
  int maximumWholesalePrice;
  int supplierPrice;
  int specialPrice;
  int vatPercentage;
  bool usePricingFormula;
  String image;
  dynamic barcode;
  int packsize;
  String description;
  String availability;
  int balance;
  String usage;
  dynamic warnings;
  bool prescription;
  int priority;
  String sellingOptions;
  int totalRevenue;
  int totalPurchases;
  String company;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    group: Category.fromJson(json["group"]),
    subgroup: Category.fromJson(json["subgroup"]),
    category: Category.fromJson(json["category"]),
    brand: Brand.fromJson(json["brand"]),
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
    totalPurchases: json["total_purchases"],
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

class Brand {
  Brand({
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

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    shortName: json["short_name"],
    country: json["country"],
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
    "short_name": shortName,
    "country": country,
    "company": company,
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
