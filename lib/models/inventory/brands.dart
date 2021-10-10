// To parse this JSON data, do
//
//     final brands = brandsFromJson(jsonString);

import 'dart:convert';

Brands brandsFromJson(String str) => Brands.fromJson(json.decode(str));

String brandsToJson(Brands data) => json.encode(data.toJson());

class Brands {
  Brands({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json['results'] != null ? new List<Result>.from(json["results"].map((x) => Result.fromJson(x))) :List<Result>(),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.country,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.deletedAt,
    this.name,
    this.shortName,
    this.company,
  });

  String id;
  dynamic country;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isActive;
  bool isDeleted;
  dynamic deletedAt;
  String name;
  dynamic shortName;
  String company;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    country: json["country"],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    modifiedAt: json['modified_at'] == null ? null : DateTime.parse(json['modified_at'] as String),
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    name: json["name"],
    shortName: json["short_name"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "name": name,
    "short_name": shortName,
    "company": company,
  };
}
