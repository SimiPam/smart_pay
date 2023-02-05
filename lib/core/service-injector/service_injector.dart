import 'package:smart_pay/core/services/auth_service.dart';
import 'package:smart_pay/core/services/dashboard_service.dart';

import '../services/services.dart';

class Injector {
  StorageService storageService = StorageService();
  ApiService? apiService;
  AuthService? authService;
  DashboardService? dashboardService;

  Future<bool> init() async {
    await storageService.initStorage();

    apiService = ApiService();
    authService = AuthService(storageService: storageService);
    dashboardService = DashboardService(storageService: storageService);
    return true;
  }
}

Injector si = Injector();
