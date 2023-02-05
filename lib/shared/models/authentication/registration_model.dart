// To parse this JSON data, do
//
//     final registrationPayload = registrationPayloadFromJson(jsonString);

import 'dart:convert';

RegistrationPayload registrationPayloadFromJson(String str) =>
    RegistrationPayload.fromJson(json.decode(str));

String registrationPayloadToJson(RegistrationPayload data) =>
    json.encode(data.toJson());

class RegistrationPayload {
  RegistrationPayload({
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
  List<dynamic>? meta;
  List<dynamic>? pagination;
  ErrorsForRegisteration? errors;

  factory RegistrationPayload.fromJson(Map<String, dynamic> json) =>
      RegistrationPayload(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null
            ? null
            : ErrorsForRegisteration.fromJson(json["errors"]),
        meta: json["meta"] == null
            ? []
            : List<dynamic>.from(json["meta"]!.map((x) => x)),
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
        "errors": errors?.toJson(),
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
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
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.id,
  });

  String? fullName;
  String? username;
  String? email;
  String? country;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        country: json["country"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "username": username,
        "email": email,
        "country": country,
        "id": id,
      };
}

class ErrorsForRegisteration {
  ErrorsForRegisteration({
    this.fullName,
    this.email,
    this.password,
    this.country,
    this.deviceName,
  });

  List<String>? fullName;
  List<String>? email;
  List<String>? password;
  List<String>? country;
  List<String>? deviceName;

  factory ErrorsForRegisteration.fromJson(Map<String, dynamic> json) =>
      ErrorsForRegisteration(
        fullName: json["full_name"] == null
            ? []
            : List<String>.from(json["full_name"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
        country: json["country"] == null
            ? []
            : List<String>.from(json["country"]!.map((x) => x)),
        deviceName: json["device_name"] == null
            ? []
            : List<String>.from(json["device_name"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "full_name":
            fullName == null ? [] : List<dynamic>.from(fullName!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "password":
            password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
        "country":
            country == null ? [] : List<dynamic>.from(country!.map((x) => x)),
        "device_name": deviceName == null
            ? []
            : List<dynamic>.from(deviceName!.map((x) => x)),
      };
}
