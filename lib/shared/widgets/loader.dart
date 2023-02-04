import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_pay/shared/utils/color.dart';

class Loader extends StatelessWidget {
  final double? radius;
  final Color color;
  const Loader({this.radius, this.color = AppColors.primaryColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius ?? 35,
      height: radius ?? 35,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color))
          : CupertinoActivityIndicator(
              radius: radius ?? 20,
            ),
    );
  }
}
