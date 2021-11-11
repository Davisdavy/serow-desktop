
import 'dart:convert';

PostingCategories postingCategoriesFromJson(String str) => PostingCategories.fromJson(json.decode(str));
class PostingCategories {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  PostingCategories({this.count, this.next, this.previous, this.results});

  PostingCategories.fromJson(Map<String, dynamic> json) {
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
  Account account;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String code;
  String name;
  String company;

  Results(
      {this.id,
        this.account,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.name,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    code = json['code'];
    name = json['name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['code'] = this.code;
    data['name'] = this.name;
    data['company'] = this.company;
    return data;
  }
}

class Account {
  String id;
  Group group;
  Subgroup subgroup;
  dynamic category;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  String code;
  double bEGDR;
  double bEGCR;
  double pREVDR;
  double pREVCR;
  double cURDR;
  double cURCR;
  bool hasDepreciationAccount;
  String type;
  String company;
  String costCentre;

  Account(
      {this.id,
        this.group,
        this.subgroup,
        this.category,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.code,
        this.bEGDR,
        this.bEGCR,
        this.pREVDR,
        this.pREVCR,
        this.cURDR,
        this.cURCR,
        this.hasDepreciationAccount,
        this.type,
        this.company,
        this.costCentre});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    subgroup = json['subgroup'] != null
        ? new Subgroup.fromJson(json['subgroup'])
        : null;
    category = json['category'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    code = json['code'];
    bEGDR = json['BEGDR'];
    bEGCR = json['BEGCR'];
    pREVDR = json['PREVDR'];
    pREVCR = json['PREVCR'];
    cURDR = json['CURDR'];
    cURCR = json['CURCR'];
    hasDepreciationAccount = json['has_depreciation_account'];
    type = json['type'];
    company = json['company'];
    costCentre = json['cost_centre'];
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
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['code'] = this.code;
    data['BEGDR'] = this.bEGDR;
    data['BEGCR'] = this.bEGCR;
    data['PREVDR'] = this.pREVDR;
    data['PREVCR'] = this.pREVCR;
    data['CURDR'] = this.cURDR;
    data['CURCR'] = this.cURCR;
    data['has_depreciation_account'] = this.hasDepreciationAccount;
    data['type'] = this.type;
    data['company'] = this.company;
    data['cost_centre'] = this.costCentre;
    return data;
  }
}

class Group {
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String shortname;
  int number;
  int noOfIntegers;
  String type;
  String company;

  Group(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.shortname,
        this.number,
        this.noOfIntegers,
        this.type,
        this.company});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    shortname = json['shortname'];
    number = json['number'];
    noOfIntegers = json['no_of_integers'];
    type = json['type'];
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
    data['shortname'] = this.shortname;
    data['number'] = this.number;
    data['no_of_integers'] = this.noOfIntegers;
    data['type'] = this.type;
    data['company'] = this.company;
    return data;
  }
}

class Subgroup {
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String shortname;
  int number;
  int noOfIntegers;
  String group;
  String company;

  Subgroup(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.shortname,
        this.number,
        this.noOfIntegers,
        this.group,
        this.company});

  Subgroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    shortname = json['shortname'];
    number = json['number'];
    noOfIntegers = json['no_of_integers'];
    group = json['group'];
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
    data['shortname'] = this.shortname;
    data['number'] = this.number;
    data['no_of_integers'] = this.noOfIntegers;
    data['group'] = this.group;
    data['company'] = this.company;
    return data;
  }
}