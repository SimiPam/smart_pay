import 'package:smart_pay/core/services/storage_service.dart';
import 'package:smart_pay/shared/models/dashboard/dashboard_model.dart';

import '../../shared/models/api_model.dart';
import '../service-injector/service_injector.dart';

class DashboardService {
  DashboardService({
    required this.storageService,
  });

  StorageService storageService;

  Future<ApiResponse<DashboardPayload>> getSecretMsg() {
    return si.apiService!.getApi<DashboardPayload>(
      'dashboard',
      useToken: true,
      transform: (dynamic res) {
        return DashboardPayload.fromJson(res);
      },
    );
  }
}
