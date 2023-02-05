import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_pay/shared/models/dashboard/dashboard_model.dart';

import '../../../core/base/base_viewmodel.dart';
import '../../../core/service-injector/service_injector.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/widgets/custom_snackbar.dart';

class DashboardViewModel extends BaseViewModel {
  final BuildContext? context;

  DashboardViewModel({this.context});

  @override
  FutureOr<void> init() async {
    // TODO: implement init
    await getSecretMsg(context);
  }

  String? _message;
  String _secretMsg = "No secret message found!\nSwipe down to try again";

  String? get secretMsg => _secretMsg;

  Future<void> refreshContent() async {
    await getSecretMsg(context!);
  }

  Future<void> getSecretMsg(BuildContext? context) async {
    try {
      final ApiResponse<DashboardPayload> res =
          await si.dashboardService!.getSecretMsg();

      if (res.status == false) {
        snackBar(
            context: context!,
            message: "No secret message found!\nSwipe down to try again",
            isError: true);
        setLoadingState(false);
      } else {
        _message = res.data!.message;
        _secretMsg = res.data!.data!.secret!;
        setLoadingState(false);
      }
    } catch (e) {
      setLoadingState(false);
      _message = e.toString();
      snackBar(
          context: context!,
          message: "No secret message found!\nSwipe down to try again",
          isError: true);
      debugPrint("error on catch block_______ $_message");
    }
  }
}
