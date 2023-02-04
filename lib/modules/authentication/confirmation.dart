import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/router/route_paths.dart';
import 'package:smart_pay/shared/utils/assets.dart';
import 'package:smart_pay/shared/utils/color.dart';
import 'package:smart_pay/shared/widgets/space.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/custom_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight(context).h,
        width: deviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // HSpace(180.h),
            // SvgPicture.asset(SvgAssets.confirmLogo),
            Image.asset(
              ImageAssets.confirmLogo,
              width: 140.45.w,
              height: 134.33.h,
            ),
            HSpace(32.h),
            Styles.bold("Congratulations, James",
                align: TextAlign.center, color: AppColors.primaryColor),
            HSpace(12.h),
            Styles.regular(
                'You’ve completed the onboarding,\nyou can start using',
                color: AppColors.greyscaleTextColor,
                align: TextAlign.center,
                fontSize: 16.sp),
            HSpace(32.h),
            CustomButton(
                margin: 0.w,
                title: 'Get Started',
                isActive: true,
                nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                txtColor: AppColors.white,
                txtSize: 17.sp,
                fontWeight: FWt.bold,
                onPress: () {
                  navPushReplace(context, RoutePaths.home);
                }),
          ],
        ),
      ),
    );
  }
}
