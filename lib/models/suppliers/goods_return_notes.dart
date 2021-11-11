// To parse this JSON data, do
//
//     final goodsReturnNotes = goodsReturnNotesFromJson(jsonString);

import 'dart:convert';

GoodsReturnNotes goodsReturnNotesFromJson(String str) => GoodsReturnNotes.fromJson(json.decode(str));

String goodsReturnNotesToJson(GoodsReturnNotes data) => json.encode(data.toJson());

class GoodsReturnNotes {
  GoodsReturnNotes({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Results> results;

  factory GoodsReturnNotes.fromJson(Map<String, dynamic> json) => GoodsReturnNotes(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Results {
  Results({
    this.id,
    this.goodsReturnNoteItems,
    this.supplier,
    this.branch,
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
    this.totalCost,
    this.noOfItems,
    this.notes,
    this.status,
    this.postedAt,
    this.company,
  });

  String id;
  List<GoodsReturnNoteItem> goodsReturnNoteItems;
  Supplier supplier;
  Branch branch;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  double tradeDiscountPercentage;
  DateTime paymentDate;
  double discountAmount;
  double totalNet;
  double taxAmount;
  double totalAmount;
  double totalCost;
  int noOfItems;
  dynamic notes;
  String status;
  DateTime postedAt;
  String company;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"],
    goodsReturnNoteItems: List<GoodsReturnNoteItem>.from(json["goods_return_note_items"].map((x) => GoodsReturnNoteItem.fromJson(x))),
    supplier: Supplier.fromJson(json["supplier"]),
    branch: Branch.fromJson(json["branch"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    tradeDiscountPercentage: json["trade_discount_percentage"],
    paymentDate: DateTime.parse(json["payment_date"]),
    discountAmount: json["discount_amount"],
    totalNet: json["total_net"],
    taxAmount: json["tax_amount"],
    totalAmount: json["total_amount"],
    totalCost: json["total_cost"],
    noOfItems: json["no_of_items"],
    notes: json["notes"],
    status: json["status"],
    postedAt: DateTime.parse(json["posted_at"]),
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "goods_return_note_items": List<dynamic>.from(goodsReturnNoteItems.map((x) => x.toJson())),
    "supplier": supplier.toJson(),
    "branch": branch.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "code": code,
    "trade_discount_percentage": tradeDiscountPercentage,
    "payment_date": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
    "discount_amount": discountAmount,
    "total_net": totalNet,
    "tax_amount": taxAmount,
    "total_amount": totalAmount,
    "total_cost": totalCost,
    "no_of_items": noOfItems,
    "notes": notes,
    "status": status,
    "posted_at": postedAt.toIso8601String(),
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

class GoodsReturnNoteItem {
  GoodsReturnNoteItem({
    this.id,
    this.item,
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
    this.goodsReturnNote,
    this.branch,
    this.company,
  });

  String id;
  Item item;
  List<GoodsReturnNoteItemDetail> goodsReturnNoteItemDetails;
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
  double taxPercentage;
  double taxAmount;
  double totalCost;
  String goodsReturnNote;
  String branch;
  String company;

  factory GoodsReturnNoteItem.fromJson(Map<String, dynamic> json) => GoodsReturnNoteItem(
    id: json["id"],
    item: Item.fromJson(json["item"]),
    goodsReturnNoteItemDetails: List<GoodsReturnNoteItemDetail>.from(json["goods_return_note_item_details"].map((x) => GoodsReturnNoteItemDetail.fromJson(x))),
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
    taxPercentage: json["tax_percentage"],
    taxAmount: json["tax_amount"],
    totalCost: json["total_cost"],
    goodsReturnNote: json["goods_return_note"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item.toJson(),
    "goods_return_note_item_details": List<dynamic>.from(goodsReturnNoteItemDetails.map((x) => x.toJson())),
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
    "tax_percentage": taxPercentage,
    "tax_amount": taxAmount,
    "total_cost": totalCost,
    "goods_return_note": goodsReturnNote,
    "branch": branch,
    "company": company,
  };
}

class GoodsReturnNoteItemDetail {
  GoodsReturnNoteItemDetail({
    this.id,
    this.location,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.quantity,
    this.expiryDate,
    this.batchNumber,
    this.goodsReturnNoteItem,
    this.branch,
    this.company,
  });

  String id;
  PostingCategory location;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  double quantity;
  DateTime expiryDate;
  String batchNumber;
  String goodsReturnNoteItem;
  String branch;
  String company;

  factory GoodsReturnNoteItemDetail.fromJson(Map<String, dynamic> json) => GoodsReturnNoteItemDetail(
    id: json["id"],
    location: PostingCategory.fromJson(json["location"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    quantity: json["quantity"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    batchNumber: json["batch_number"],
    goodsReturnNoteItem: json["goods_return_note_item"],
    branch: json["branch"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "quantity": quantity,
    "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
    "batch_number": batchNumber,
    "goods_return_note_item": goodsReturnNoteItem,
    "branch": branch,
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
    this.isHead,
    this.branch,
    this.company,
    this.account,
  });

  String id;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  bool isHead;
  String branch;
  String company;
  String account;

  factory PostingCategory.fromJson(Map<String, dynamic> json) => PostingCategory(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    code: json["code"],
    name: json["name"],
    isHead: json["is_head"] == null ? null : json["is_head"],
    branch: json["branch"] == null ? null : json["branch"],
    company: json["company"],
    account: json["account"] == null ? null : json["account"],
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
    "is_head": isHead == null ? null : isHead,
    "branch": branch == null ? null : branch,
    "company": company,
    "account": account == null ? null : account,
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
  dynamic description;
  String availability;
  double balance;
  dynamic usage;
  dynamic warnings;
  bool prescription;
  int priority;
  String sellingOptions;
  double totalRevenue;
  double totalPurchases;
  dynamic pricing;
  dynamic brand;
  dynamic itemForm;
  dynamic strength;
  String group;
  String subgroup;
  dynamic category;
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
    avgCostPrice: json["avg_cost_price"],
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
