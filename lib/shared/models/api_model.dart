// ignore_for_file: prefer_if_null_operators, unnecessary_overrides

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse<T> {
  ApiResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
    this.errors,
  });

  bool? status;
  String? message;
  T? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;
  dynamic errors;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"],
      meta: json["meta"] == null
          ? []
          : List<dynamic>.from(json["meta"]!.map((x) => x)),
      pagination: json["pagination"] == null
          ? []
          : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      errors: json["errors"] == null);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
        "errors": errors,
      };

  @override
  String toString() {
    return super.toString();
  }
}
