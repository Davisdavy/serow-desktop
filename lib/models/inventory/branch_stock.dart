// To parse this JSON data, do
//
//     final branchStock = branchStockFromJson(jsonString);

import 'dart:convert';

BranchStock branchStockFromJson(String str) => BranchStock.fromJson(json.decode(str));

String branchStockToJson(BranchStock data) => json.encode(data.toJson());

class BranchStock {
  BranchStock({
    this.id,
    this.item,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
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
    this.packsize,
    this.availability,
    this.openingStock,
    this.balance,
    this.reorder,
    this.totalRevenue,
    this.totalPurchases,
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
  int packsize;
  String availability;
  double openingStock;
  double balance;
  double reorder;
  double totalRevenue;
  double totalPurchases;
  String branch;
  String company;

  factory BranchStock.fromJson(Map<String, dynamic> json) => BranchStock(
    id: json["id"],
    item: Item.fromJson(json["item"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
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
    packsize: json["packsize"],
    availability: json["availability"],
    openingStock: json["opening_stock"],
    balance: json["balance"],
    reorder: json["reorder"],
    totalRevenue: json["total_revenue"],
    totalPurchases: json["total_purchases"],
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
    "packsize": packsize,
    "availability": availability,
    "opening_stock": openingStock,
    "balance": balance,
    "reorder": reorder,
    "total_revenue": totalRevenue,
    "total_purchases": totalPurchases,
    "branch": branch,
    "company": company,
  };
}

class Item {
  Item({
    this.id,
    this.imageUrl,
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
    this.pricing,
    this.brand,
    this.itemForm,
    this.strength,
    this.group,
    this.subgroup,
    this.category,
    this.company,
  });

  String id;
  String imageUrl;
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
  dynamic pricing;
  String brand;
  String itemForm;
  String strength;
  String group;
  String subgroup;
  String category;
  String company;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    imageUrl: json["image_url"],
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
    pricing: json["pricing"],
    brand: json["brand"],
    itemForm: json["item_form"],
    strength: json["strength"],
    group: json["group"],
    subgroup: json["subgroup"],
    category: json["category"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
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
    "pricing": pricing,
    "brand": brand,
    "item_form": itemForm,
    "strength": strength,
    "group": group,
    "subgroup": subgroup,
    "category": category,
    "company": company,
  };
}
