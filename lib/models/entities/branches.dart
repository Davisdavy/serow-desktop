// To parse this JSON data, do
//
//     final branches = branchesFromJson(jsonString);

import 'dart:convert';

Branches branchesFromJson(String str) => Branches.fromJson(json.decode(str));

String branchesToJson(Branches data) => json.encode(data.toJson());

class Branches {
  Branches({
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

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
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
