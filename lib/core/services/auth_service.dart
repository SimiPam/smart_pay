import 'dart:async';
import 'dart:convert';

import 'package:smart_pay/core/services/storage_service.dart';

import '../../shared/models/authentication/auth_model.dart';

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
}
