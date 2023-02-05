import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

Future<bool> onBackPressed(BuildContext context) async {
  bool result = false;
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Styles.medium(
        "Exit \n\nAre you sure?",
        color: AppColors.primaryColor,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.red,
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: Styles.regular(
            "CANCEL",
            fontSize: 14.sp,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          ),
          onPressed: () {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
            result = true;
          },
          child: Styles.regular(
            "YES",
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );

  return result;
}
