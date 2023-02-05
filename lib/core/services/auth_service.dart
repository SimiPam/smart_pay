import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_pay/core/services/storage_service.dart';
import 'package:smart_pay/shared/models/authentication/verify_email_model.dart';

import '../../shared/models/api_model.dart';
import '../../shared/models/authentication/auth_model.dart';
import '../../shared/models/authentication/create_account_model.dart';
import '../../shared/models/authentication/registration_model.dart';
import '../service-injector/service_injector.dart';

class AuthService {
  AuthService({
    required this.storageService,
  });

  StorageService storageService;

  Future<bool> isLoggedIn() async {
    final AuthPayload auth = await getAuthData();
    return auth.data!.token != null && auth.data!.token!.isNotEmpty;
  }

  Future<AuthPayload> getAuthData() async {
    final Completer<AuthPayload> completer = Completer<AuthPayload>();

    final String data = storageService.getItemSync('auth_data');

    if (data.isEmpty) {
      completer.complete(null);
    } else {
      final AuthPayload auth = AuthPayload.fromJson(json.decode(data));
      completer.complete(auth);
    }

    return completer.future;
  }

  Future<ApiResponse<CreateAccountPayload>> createAccount(
      Map<String, String> body) {
    return si.apiService!.postApi<CreateAccountPayload>(
      'auth/email',
      body,
      useToken: false,
      transform: (dynamic res) {
        return CreateAccountPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<VeriftyEmailPayload>> verifyEmail(
      Map<String, String> body) {
    return si.apiService!.postApi<VeriftyEmailPayload>(
      'auth/email/verify',
      body,
      useToken: false,
      transform: (dynamic res) {
        debugPrint("... $res");
        return VeriftyEmailPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<RegistrationPayload>> registerUser(
      Map<String, String> body) {
    return si.apiService!.postApi<RegistrationPayload>(
      'auth/register',
      body,
      useToken: false,
      transform: (dynamic res) {
        return RegistrationPayload.fromJson(res);
      },
    );
  }

  Future<ApiResponse<AuthPayload>> signInUser(Map<String, String> body) {
    return si.apiService!.postApi<AuthPayload>(
      'auth/login',
      body,
      useToken: false,
      transform: (dynamic res) {
        debugPrint("88 $res");
        return AuthPayload.fromJson(res);
      },
    );
  }
}
