// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/shared/utils/utils.dart';
import 'package:smart_pay/shared/widgets/space.dart';

import '../../../shared/utils/color.dart';

class OnboardingImages extends StatelessWidget {
  final String image;
  final double? height;
  const OnboardingImages({Key? key, required this.image, this.height = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 1,
            ),
            SizedBox(
              width: 250.w,
              height: 250.h,
              child: SvgPicture.asset(
                image,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    ));
  }
}

class OnboardingText extends StatelessWidget {
  final String headerText;
  final String subTitle;
  const OnboardingText({
    Key? key,
    required this.headerText,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Styles.medium(
              headerText,
              align: TextAlign.center,
              color: AppColors.primaryColor,
              fontSize: 24.sp,
            ),
          ),
          HSpace(16.h),
          Styles.regular(
            subTitle,
            align: TextAlign.center,
            color: AppColors.greyscaleTextColor,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}
