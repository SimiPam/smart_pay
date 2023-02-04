import 'package:smart_pay/core/services/auth_service.dart';

import '../services/services.dart';

class Injector {
  StorageService storageService = StorageService();
  ApiService? apiService;
  AuthService? authService;

  Future<bool> init() async {
    await storageService.initStorage();

    apiService = ApiService();
    authService = AuthService(storageService: storageService);
    return true;
  }
}

Injector si = Injector();
