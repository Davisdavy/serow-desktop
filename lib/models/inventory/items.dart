
import 'dart:convert';

import 'package:serow/models/inventory/categories.dart';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
class Items {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Items({this.count, this.next, this.previous, this.results});

  Items.fromJson(Map<String, dynamic> json) {
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
  Group group;
  Subgroup subgroup;
  Categories category;
  Brand brand;
  dynamic itemForm;
  dynamic strength;
  dynamic pricing;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  dynamic no;
  String code;
  String name;
  String slug;
  dynamic costPrice;
  dynamic avgCostPrice;
  dynamic tradePrice;
  dynamic retailPrice;
  dynamic minimumPrice;
  dynamic maximumPrice;
  dynamic wholesalePrice;
  dynamic minimumWholesalePrice;
  dynamic maximumWholesalePrice;
  dynamic supplierPrice;
  dynamic specialPrice;
  dynamic vatPercentage;
  bool usePricingFormula;
  String image;
  dynamic  barcode;
  dynamic packsize;
  dynamic  description;
  String availability;
  dynamic balance;
  dynamic  usage;
  dynamic  warnings;
  bool prescription;
  dynamic priority;
  String sellingOptions;
  dynamic totalRevenue;
  dynamic totalPurchases;
  String company;

  Results(
      {this.id,
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
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    subgroup = json['subgroup'] != null
        ? new Subgroup.fromJson(json['subgroup'])
        : null;
    category = json['category'] != null ? Categories.fromJson(json['category']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    itemForm = json['item_form'];
    strength = json['strength'];
    pricing = json['pricing'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    no = json['no'];
    code = json['code'];
    name = json['name'];
    slug = json['slug'];
    costPrice = json['cost_price'];
    avgCostPrice = json['avg_cost_price'];
    tradePrice = json['trade_price'];
    retailPrice = json['retail_price'];
    minimumPrice = json['minimum_price'];
    maximumPrice = json['maximum_price'];
    wholesalePrice = json['wholesale_price'];
    minimumWholesalePrice = json['minimum_wholesale_price'];
    maximumWholesalePrice = json['maximum_wholesale_price'];
    supplierPrice = json['supplier_price'];
    specialPrice = json['special_price'];
    vatPercentage = json['vat_percentage'];
    usePricingFormula = json['use_pricing_formula'];
    image = json['image'];
    barcode = json['barcode'];
    packsize = json['packsize'];
    description = json['description'];
    availability = json['availability'];
    balance = json['balance'];
    usage = json['usage'];
    warnings = json['warnings'];
    prescription = json['prescription'];
    priority = json['priority'];
    sellingOptions = json['selling_options'];
    totalRevenue = json['total_revenue'];
    totalPurchases = json['total_purchases'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    if (this.subgroup != null) {
      data['subgroup'] = this.subgroup.toJson();
    }
    data['category'] = this.category;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['item_form'] = this.itemForm;
    data['strength'] = this.strength;
    data['pricing'] = this.pricing;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['no'] = this.no;
    data['code'] = this.code;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['cost_price'] = this.costPrice;
    data['avg_cost_price'] = this.avgCostPrice;
    data['trade_price'] = this.tradePrice;
    data['retail_price'] = this.retailPrice;
    data['minimum_price'] = this.minimumPrice;
    data['maximum_price'] = this.maximumPrice;
    data['wholesale_price'] = this.wholesalePrice;
    data['minimum_wholesale_price'] = this.minimumWholesalePrice;
    data['maximum_wholesale_price'] = this.maximumWholesalePrice;
    data['supplier_price'] = this.supplierPrice;
    data['special_price'] = this.specialPrice;
    data['vat_percentage'] = this.vatPercentage;
    data['use_pricing_formula'] = this.usePricingFormula;
    data['image'] = this.image;
    data['barcode'] = this.barcode;
    data['packsize'] = this.packsize;
    data['description'] = this.description;
    data['availability'] = this.availability;
    data['balance'] = this.balance;
    data['usage'] = this.usage;
    data['warnings'] = this.warnings;
    data['prescription'] = this.prescription;
    data['priority'] = this.priority;
    data['selling_options'] = this.sellingOptions;
    data['total_revenue'] = this.totalRevenue;
    data['total_purchases'] = this.totalPurchases;
    data['company'] = this.company;
    return data;
  }
}

class Group {
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String slug;
  dynamic priority;
  String company;

  Group(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.slug,
        this.priority,
        this.company});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    slug = json['slug'];
    priority = json['priority'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['priority'] = this.priority;
    data['company'] = this.company;
    return data;
  }
}

class Subgroup {
  String id;
  Group group;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String slug;
  String company;

  Subgroup(
      {this.id,
        this.group,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.slug,
        this.company});

  Subgroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    slug = json['slug'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['company'] = this.company;
    return data;
  }
}

class Brand {
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  dynamic shortName;
  dynamic country;
  String company;

  Brand(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.shortName,
        this.country,
        this.company});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    shortName = json['short_name'];
    country = json['country'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['country'] = this.country;
    data['company'] = this.company;
    return data;
  }
}