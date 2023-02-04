import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/shared/utils/color.dart';
import 'package:smart_pay/shared/widgets/space.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context: context),
      body: Container(
        height: deviceHeight(context).h,
        width: deviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Styles.bold("Congratulations, James",
                align: TextAlign.center, color: AppColors.primaryColor),
            HSpace(12.h),
            Styles.regular(
                'You’ve completed the onboarding,\nyou can start using',
                color: AppColors.greyscaleTextColor,
                align: TextAlign.center,
                fontSize: 16.sp),
          ],
        ),
      ),
    );
  }
}
