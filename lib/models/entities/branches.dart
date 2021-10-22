import 'dart:convert';

Branches branchesFromJson(String str) => Branches.fromJson(json.decode(str));

class Branches {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Branches({this.count, this.next, this.previous, this.results});

  Branches.fromJson(Map<String, dynamic> json) {
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
  String company;

  Results(
      {this.id,
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
        this.company});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['description'] = this.description;
    data['email'] = this.email;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['is_head'] = this.isHead;
    data['region'] = this.region;
    data['cost_centre'] = this.costCentre;
    data['company'] = this.company;
    return data;
  }
}