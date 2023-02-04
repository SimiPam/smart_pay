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
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 15));
      // print('URL____$uri');
      // print('Token____${headers.values}');
      final dynamic data = json.decode(res.body ?? '');

      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
      } else {
        // print('Api error at $uri and $data');

        apiResponse.status = false;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.status = false;
      //debugPrint(e.toString());
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      debugPrint(e.toString());

      apiResponse.status = false;
      apiResponse.message = e.toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApiAdd<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders(customHeaders);
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await http
          .post(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 15));
      // print('URL___ $uri');
      // print('body___ ${httpBody(body)}');

      final dynamic data = json.decode(res.body);
      // print('ResponesData---- $data');
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
      } else {
        //apiResponse.error = true;
        apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.status = false;
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      debugPrint(e.toString());
      apiResponse.status = false;
      apiResponse.message = (e ?? 'Error encountered').toString();
    }

    return apiResponse;
  }
}
