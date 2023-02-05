// To parse this JSON data, do
//
//     final veriftyEmailPayload = veriftyEmailPayloadFromJson(jsonString);

import 'dart:convert';

VeriftyEmailPayload veriftyEmailPayloadFromJson(String str) =>
    VeriftyEmailPayload.fromJson(json.decode(str));

String veriftyEmailPayloadToJson(VeriftyEmailPayload data) =>
    json.encode(data.toJson());

class VeriftyEmailPayload {
  VeriftyEmailPayload({
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
  Errors? errors;

  factory VeriftyEmailPayload.fromJson(Map<String, dynamic> json) =>
      VeriftyEmailPayload(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null
            ? []
            : List<dynamic>.from(json["meta"]!.map((x) => x)),
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
        "errors": errors?.toJson(),
      };
}

class Errors {
  Errors({
    this.email,
    this.token,
  });

  List<String>? email;
  List<String>? token;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        token: json["token"] == null
            ? []
            : List<String>.from(json["token"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "token": token == null ? [] : List<dynamic>.from(token!.map((x) => x)),
      };
}

class Data {
  Data({
    this.email,
  });

  String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
