import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/shared/utils/color.dart';

import '../utils/utils.dart';

class CustomButton extends StatefulWidget {
  final Widget? icon;
  final String title;
  final VoidCallback onPress;
  final Color? txtColor;
  final double? width;
  final double? height;
  final bool hasElevation;
  final double? txtSize;
  final bool isActive;
  final Color? btnColor;
  final Color? nonActiveBtnColor;
  final FontWeight? fontWeight;
  final double margin;

  const CustomButton({
    Key? key,
    this.icon,
    required this.margin,
    required this.title,
    this.nonActiveBtnColor,
    required this.onPress,
    this.txtColor = AppColors.white,
    this.fontWeight,
    this.txtSize,
    this.width,
    this.btnColor = AppColors.primaryColor,
    this.height,
    this.isActive = false,
    this.hasElevation = false,
    // this.isGradient = true
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: widget.isActive ? widget.btnColor! : widget.nonActiveBtnColor!,
          width: 0.8,
        ),
        color: widget.isActive ? widget.btnColor : widget.nonActiveBtnColor,
      ),
      width: widget.width ?? deviceWidth(context).w,
      height: widget.height ?? 60.h,
      child: TextButton(
        onPressed: widget.isActive ? widget.onPress : () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: BorderSide(
                      color: widget.isActive
                          ? widget.btnColor!
                          : widget.nonActiveBtnColor!)),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
            backgroundColor: MaterialStateProperty.all<Color>(widget.isActive
                ? widget.btnColor!
                : widget.nonActiveBtnColor!)),
        child: Styles.regular(
          widget.title,
          color: widget.txtColor ?? AppColors.white,
          fontSize: widget.txtSize ?? 14.sp,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
