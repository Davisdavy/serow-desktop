// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  String accessToken;
  String refreshToken;
  User user;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.email,
    this.profile,
    this.firstName,
    this.lastName,
    this.fullName,
    this.role,
    this.usable,
    this.phone,
    this.isActive,
    this.isDeleted,
    this.isOpsAdmin,
    this.isEmployee,
    this.isSupplier,
    this.isCustomer,
    this.groups,
    this.userPermissions,
  });

  String id;
  String email;
  String profile;
  String firstName;
  String lastName;
  String fullName;
  String role;
  bool usable;
  dynamic phone;
  bool isActive;
  bool isDeleted;
  bool isOpsAdmin;
  bool isEmployee;
  bool isSupplier;
  bool isCustomer;
  List<int> groups;
  List<dynamic> userPermissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    profile: json["profile"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    fullName: json["full_name"],
    role: json["role"],
    usable: json["usable"],
    phone: json["phone"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    isOpsAdmin: json["is_ops_admin"],
    isEmployee: json["is_employee"],
    isSupplier: json["is_supplier"],
    isCustomer: json["is_customer"],
    groups:json["groups"] != null ? new List<int>.from(json["groups"].map((x) => x)) : List<int>(),
      userPermissions: json["user_permissions"] != null ? new List<dynamic>.from(json["user_permissions"].map((x) => x)) :List<dynamic>(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "profile": profile,
    "first_name": firstName,
    "last_name": lastName,
    "full_name": fullName,
    "role": role,
    "usable": usable,
    "phone": phone,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "is_ops_admin": isOpsAdmin,
    "is_employee": isEmployee,
    "is_supplier": isSupplier,
    "is_customer": isCustomer,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
  };
}
