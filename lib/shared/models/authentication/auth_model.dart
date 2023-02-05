// To parse this JSON data, do
//
//     final authPayload = authPayloadFromJson(jsonString);

import 'dart:convert';

AuthPayload authPayloadFromJson(String str) =>
    AuthPayload.fromJson(json.decode(str));

String authPayloadToJson(AuthPayload data) => json.encode(data.toJson());

class AuthPayload {
  AuthPayload({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
    this.errors,
  });

  bool? status;
  String? message;
  Data? data;
  Errors? errors;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory AuthPayload.fromJson(Map<String, dynamic> json) => AuthPayload(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null
            ? []
            : List<dynamic>.from(json["meta"]!.map((x) => x)),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors?.toJson(),
        "data": data?.toJson(),
        "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Errors {
  Errors({
    this.email,
    this.password,
    this.deviceName,
  });

  List<String>? email;
  List<String>? password;
  List<String>? deviceName;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
        deviceName: json["device_name"] == null
            ? []
            : List<String>.from(json["device_name"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "password":
            password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
        "device_name": deviceName == null
            ? []
            : List<dynamic>.from(deviceName!.map((x) => x)),
      };
}

class Data {
  Data({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  User({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
  });

  String? id;
  String? fullName;
  String? username;
  String? email;
  dynamic phone;
  dynamic phoneCountry;
  String? country;
  dynamic avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneCountry: json["phone_country"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_country": phoneCountry,
        "country": country,
        "avatar": avatar,
      };
}
