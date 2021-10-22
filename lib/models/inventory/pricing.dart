
import 'dart:convert';

Pricing pricingFromJson(String str) => Pricing.fromJson(json.decode(str));
class Pricing {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Pricing({this.count, this.next, this.previous, this.results});

  Pricing.fromJson(Map<String, dynamic> json) {
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
  List<PricingFormulas> pricingFormulas;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String company;

  Results(
      {this.id,
        this.pricingFormulas,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['pricing_formulas'] != null) {
      pricingFormulas = new List<PricingFormulas>();
      json['pricing_formulas'].forEach((v) {
        pricingFormulas.add(new PricingFormulas.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.pricingFormulas != null) {
      data['pricing_formulas'] =
          this.pricingFormulas.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['company'] = this.company;
    return data;
  }
}

class PricingFormulas {
  String id;
  String pricing;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String price;
  String value;
  double factor;
  String company;

  PricingFormulas(
      {this.id,
        this.pricing,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.price,
        this.value,
        this.factor,
        this.company});

  PricingFormulas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pricing = json['pricing'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    price = json['price'];
    value = json['value'];
    factor = json['factor'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pricing'] = this.pricing;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['price'] = this.price;
    data['value'] = this.value;
    data['factor'] = this.factor;
    data['company'] = this.company;
    return data;
  }
}