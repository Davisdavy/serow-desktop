
import 'dart:convert';

Shelves shelvesFromJson(String str) => Shelves.fromJson(json.decode(str));
class Shelves {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Shelves({this.count, this.next, this.previous, this.results});

  Shelves.fromJson(Map<String, dynamic> json) {
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
  Location location;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String company;

  Results(
      {this.id,
        this.location,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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
    if (this.location != null) {
      data['location'] = this.location.toJson();
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

class Location {
  String id;
  Branch branch;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String code;
  String name;
  String company;

  Location(
      {this.id,
        this.branch,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.code,
        this.name,
        this.company});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branch =
    json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
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
    if (this.branch != null) {
      data['branch'] = this.branch.toJson();
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

class Branch {
  String id;
  Company company;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  String description;
  String email;
  String location;
  String phone;
  bool isHead;
  Null region;
  String costCentre;

  Branch(
      {this.id,
        this.company,
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
        this.costCentre});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    description = json['description'];
    email = json['email'];
    location = json['location'];
    phone = json['phone'];
    isHead = json['is_head'];
    region = json['region'];
    costCentre = json['cost_centre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['email'] = this.email;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['is_head'] = this.isHead;
    data['region'] = this.region;
    data['cost_centre'] = this.costCentre;
    return data;
  }
}

class Company {
  String id;
  String createdAt;
  String modifiedAt;
  bool isActive;
  bool isDeleted;
  Null deletedAt;
  String name;
  Null logo;
  String description;
  String email;
  String location;
  String phone;
  String country;

  Company(
      {this.id,
        this.createdAt,
        this.modifiedAt,
        this.isActive,
        this.isDeleted,
        this.deletedAt,
        this.name,
        this.logo,
        this.description,
        this.email,
        this.location,
        this.phone,
        this.country});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    email = json['email'];
    location = json['location'];
    phone = json['phone'];
    country = json['country'];
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
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['email'] = this.email;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['country'] = this.country;
    return data;
  }
}