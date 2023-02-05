import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/dashboard/viewmodel/dashboard_vm.dart';
import 'package:smart_pay/shared/utils/color.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
        vmBuilder: (context) => DashboardViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      appBar: buildAppbar(context: context),
      body: RefreshIndicator(
        onRefresh: viewModel.refreshContent,
        child: Container(
          height: deviceHeight(context).h,
          width: deviceWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Styles.regular(viewModel.secretMsg!,
                  color: AppColors.greyscaleTextColor,
                  align: TextAlign.center,
                  fontSize: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
}
