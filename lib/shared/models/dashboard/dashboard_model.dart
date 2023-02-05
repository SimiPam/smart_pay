import 'dart:convert';

DashboardPayload dashboardPayloadFromJson(String str) =>
    DashboardPayload.fromJson(json.decode(str));

String dashboardPayloadToJson(DashboardPayload data) =>
    json.encode(data.toJson());

class DashboardPayload {
  DashboardPayload({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  Data? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory DashboardPayload.fromJson(Map<String, dynamic> json) =>
      DashboardPayload(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class Data {
  Data({
    this.secret,
  });

  String? secret;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "secret": secret,
      };
}
