// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/shared/utils/color.dart';
import 'package:smart_pay/shared/utils/styles.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Center(
        child: Styles.medium(
      "Resend Code $timerText secs",
      fontSize: 14.sp,
      color: AppColors.primaryColor,
    ));
  }
}
