// To parse this JSON data, do
//
//     final authPayload = authPayloadFromJson(jsonString);

import 'dart:convert';

CreateAccountPayload authPayloadFromJson(String str) =>
    CreateAccountPayload.fromJson(json.decode(str));

String authPayloadToJson(CreateAccountPayload data) =>
    json.encode(data.toJson());

class CreateAccountPayload {
  CreateAccountPayload({
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

  factory CreateAccountPayload.fromJson(Map<String, dynamic> json) =>
      CreateAccountPayload(
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
  });

  List<String>? email;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
      };
}

class Data {
  Data({
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
