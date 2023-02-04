import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/utils.dart';

Container socialMediaLogin(String imageUrl, BuildContext context) {
  return Container(
    width: deviceWidth(context),
    padding: EdgeInsets.symmetric(vertical: 16.4.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        width: 1,
        color: AppColors.greyscaleColor,
      ),
    ),
    child: SvgPicture.asset(imageUrl),
  );
}
