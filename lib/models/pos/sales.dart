// To parse this JSON data, do
//
//     final sales = salesFromJson(jsonString);

import 'dart:convert';

Sales salesFromJson(String str) => Sales.fromJson(json.decode(str));

String salesToJson(Sales data) => json.encode(data.toJson());

class Sales {
  Sales({
    this.id,
    this.saleItems,
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
    this.totalAmount,
    this.totalCost,
    this.totalProfit,
    this.commissionAmount,
    this.noOfItems,
    this.notes,
    this.status,
    this.postedAt,
    this.customer,
    this.quotation,
    this.salesPerson,
    this.branch,
    this.company,
  });

  String id;
  List<SaleItem> saleItems;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double discountPercentage;
  double discountAmount;
  double totalNet;
  double vatAmount;
  double totalAmount;
  double totalCost;
  double totalProfit;
  double commissionAmount;
  int noOfItems;
  dynamic notes;
  String status;
  dynamic postedAt;
  String customer;
  dynamic quotation;
  dynamic salesPerson;
  String branch;
  String company;

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
    id: json["id"],
    saleItems: List<SaleItem>.from(json["sale_items"].map((x) => SaleItem.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"].toDouble(),
    totalNet: json["total_net"],
    vatAmount: json["vat_amount"].toDouble(),
    totalAmount: json["total_amount"].toDouble(),
    totalCost: json["total_cost"],
    totalProfit: json["total_profit"],
    commissionAmount: json["commission_amount"],
    noOfItems: json["no_of_items"],
    notes: json["notes"],
    status: json["status"],
    postedAt: json["posted_at"],
    customer: json["customer"],
    quotation: json["quotation"],
    salesPerson: json["sales_person"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_items": List<dynamic>.from(saleItems.map((x) => x.toJson())),
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
    "total_amount": totalAmount,
    "total_cost": totalCost,
    "total_profit": totalProfit,
    "commission_amount": commissionAmount,
    "no_of_items": noOfItems,
    "notes": notes,
    "status": status,
    "posted_at": postedAt,
    "customer": customer,
    "quotation": quotation,
    "sales_person": salesPerson,
    "branch": branch,
    "company": company,
  };
}

class SaleItem {
  SaleItem({
    this.id,
    this.item,
    this.batch,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.quantity,
    this.unitCost,
    this.unitPrice,
    this.bonus,
    this.totalQuantity,
    this.discountPercentage,
    this.discountAmount,
    this.netAmount,
    this.vatPercentage,
    this.vatAmount,
    this.totalCost,
    this.totalAmount,
    this.totalProfit,
    this.sale,
    this.branch,
    this.company,
  });

  String id;
  Item item;
  dynamic batch;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  double unitCost;
  double unitPrice;
  double bonus;
  double totalQuantity;
  double discountPercentage;
  double discountAmount;
  double netAmount;
  double vatPercentage;
  double vatAmount;
  double totalCost;
  double totalAmount;
  double totalProfit;
  String sale;
  String branch;
  String company;

  factory SaleItem.fromJson(Map<String, dynamic> json) => SaleItem(
    id: json["id"],
    item: Item.fromJson(json["item"]),
    batch: json["batch"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    quantity: json["quantity"],
    unitCost: json["unit_cost"],
    unitPrice: json["unit_price"],
    bonus: json["bonus"],
    totalQuantity: json["total_quantity"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    netAmount: json["net_amount"],
    vatPercentage: json["vat_percentage"],
    vatAmount: json["vat_amount"].toDouble(),
    totalCost: json["total_cost"],
    totalAmount: json["total_amount"].toDouble(),
    totalProfit: json["total_profit"],
    sale: json["sale"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item.toJson(),
    "batch": batch,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "quantity": quantity,
    "unit_cost": unitCost,
    "unit_price": unitPrice,
    "bonus": bonus,
    "total_quantity": totalQuantity,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "net_amount": netAmount,
    "vat_percentage": vatPercentage,
    "vat_amount": vatAmount,
    "total_cost": totalCost,
    "total_amount": totalAmount,
    "total_profit": totalProfit,
    "sale": sale,
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
