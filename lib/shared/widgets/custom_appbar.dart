import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/shared/utils/assets.dart';

import '../../router/route_paths.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

AppBar buildAppbar(
    {required BuildContext context,
    List<Widget>? actions,
    bool isOnboarding = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    leading: isOnboarding
        ? const SizedBox()
        : GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: SvgPicture.asset(
                  SvgAssets.backArrow,
                  height: 12.h,
                  width: 6.w,
                )),
          ),
    actions: isOnboarding
        ? [
            TextButton(
              child: Styles.semiBold('Skip',
                  color: AppColors.secondaryColor, fontSize: 16.sp),
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.signUp);
              },
            ),
          ]
        : null,
  );
}
