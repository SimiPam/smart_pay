import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/shared/utils/color.dart';

import 'themes/theme.dart';

class FWt {
  FWt();

  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight mediumBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight text = FontWeight.w900;
}

class Styles {
  static Text regular(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.regular,
        color: color ?? pmTheme.text,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }

  static TextSpan spanRegular(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.regular,
        color: color ?? pmTheme.text,
        height: height,
        fontStyle: fontStyle,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }

  static Text medium(
    String text, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? align,
    double? height,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.mediumBold,
        color: color ?? pmTheme.text,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }

  static Text semiBold(
    String text, {
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    TextAlign? align,
    double? height,
    bool strike = false,
    bool underline = false,
    int? lines,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 16.0,
        fontWeight: FWt.semiBold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        //
      ),
    );
  }

  static TextSpan spanBold(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    double? height,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        fontWeight: FWt.bold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  static Text bold(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    bool strike = false,
    int? lines,
    TextOverflow? overflow,
    double? height,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        fontWeight: FWt.bold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  static Text extraBold(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    int? lines,
    bool strike = false,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 20.0,
        fontWeight: FWt.extraBold,
        color: color ?? pmTheme.text,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  static RichText richTextStyle({
    required String text1,
    required String text2,
    required String text3,
    Color? colorOne,
    Color? colorTwo,
    Color? colorThree,
    FontWeight? fontWeight,
    FontWeight? fontWeightTwo,
    FontWeight? fontWeightThree,
    double? fontSize,
    double? fontSizeTwo,
    double? fontSizeThree,
    VoidCallback? onTap,
  }) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
            color: colorOne ?? AppColors.white,
            fontWeight: fontWeight ?? FWt.mediumBold,
            fontSize: fontSize ?? 14.sp),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
                color: colorTwo ?? AppColors.primaryColor,
                fontWeight: fontWeightTwo ?? FWt.bold,
                fontSize: fontSizeTwo ?? 14.sp),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          TextSpan(
            text: text3,
            style: TextStyle(
                color: colorThree ?? AppColors.primaryColor,
                fontWeight: fontWeightThree ?? FWt.bold,
                fontSize: fontSizeThree ?? 14.sp),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }

  static RichText richTextStyleTwo({
    required String text1,
    required String text2,
    Color? colorOne,
    Color? colorTwo,
    Color? colorThree,
    FontWeight? fontWeight,
    FontWeight? fontWeightTwo,
    double? fontSize,
    double? fontSizeTwo,
    VoidCallback? onTap,
  }) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
            color: colorOne ?? AppColors.white,
            fontWeight: fontWeight ?? FWt.mediumBold,
            fontSize: fontSize ?? 14.sp),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
                color: colorTwo ?? AppColors.primaryColor,
                fontWeight: fontWeightTwo ?? FWt.bold,
                fontSize: fontSizeTwo ?? 14.sp),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
