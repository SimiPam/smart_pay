import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../shared/models/api_model.dart';
import '../../shared/models/authentication/auth_model.dart';
import '../config/app_config.dart';
import '../service-injector/service_injector.dart';

class ApiService {
  const ApiService();

  Future<Map<String, String>> httpHeaders(
      [Map<String, String>? customHeaders]) async {
    final Map<String, String> h = customHeaders ?? <String, String>{};

    if (h[HttpHeaders.contentTypeHeader] == null) {
      h[HttpHeaders.contentTypeHeader] = 'application/json; charset=UTF-8';
    }

    final AuthPayload auth = await si.authService!.getAuthData();

    if (auth.data!.token!.isNotEmpty) {
      h[HttpHeaders.authorizationHeader] = 'Bearer ${auth.data!.token}';
    }

    return h;
  }

  dynamic _jsonEncodeDateHandler(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }

    return item;
  }

  String httpBody(dynamic body) {
    return jsonEncode(body, toEncodable: _jsonEncodeDateHandler);
  }

  Future<ApiResponse<T>> getApi<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool? useToken,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      Map<String, String> headers;
      if (useToken!) {
        headers = await httpHeaders();
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      debugPrint(headers.toString());

      final http.Response res = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 15));

      final dynamic data = json.decode(res.body);
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
        apiResponse.status = true;
        apiResponse.message = data["message"];

        if (data["status"] == false) {
          apiResponse.status = false;
        }
      } else {
        apiResponse.status = false;
        apiResponse.data = null;
        apiResponse.errors = data['errors'];
        apiResponse.meta = data['meta'];
        apiResponse.pagination = data['pagination'];
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.status = false;
      apiResponse.data = null;
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      debugPrint(e.toString());
      apiResponse.status = false;
      apiResponse.data = null;
      apiResponse.message = e.toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApi<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool? useToken,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      Map<String, String> headers;
      if (useToken!) {
        headers = await httpHeaders(customHeaders);
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      final http.Response res = await http
          .post(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 15));

      final dynamic data = json.decode(res.body);

      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
        apiResponse.status = true;
        apiResponse.message = data["message"];

        if (data["status"] == false) {
          apiResponse.status = false;
        }
      } else {
        apiResponse.status = false;
        apiResponse.data = null;
        apiResponse.errors = data['errors'];
        apiResponse.meta = data['meta'];
        apiResponse.pagination = data['pagination'];
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.status = false;
      apiResponse.data = null;
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      debugPrint(e.toString());
      apiResponse.status = false;
      apiResponse.data = null;
      apiResponse.message = e.toString();
    }

    return apiResponse;
  }
}
