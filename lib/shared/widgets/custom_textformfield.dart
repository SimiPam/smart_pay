// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/shared/utils/color.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? obscureText;
  String? hintText;
  final Widget? icon;
  String? label;
  // final IconData? suffixIcon;
  Color? labelColor;
  final String? Function(String?)? validator;
  // Function(String) onSaved;
  // Function()? onSaved;
  final void Function(String)? onSaved;
  Function()? onTap;
  Color? fillingColor;
  bool autofocus;
  bool isEnabled;
  FontWeight? fontWeight;
  TextInputType? keyboardType;
  int? maxLines;
  TextInputType? textInputType;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  String? labelText;
  bool? filled;
  AutovalidateMode? autovalidateMode;

  CustomTextFormField(
      {Key? key,
      this.textInputType,
      this.prefixIcon,
      this.suffixIcon,
      this.autovalidateMode,
      this.fontWeight,
      // this.maxLines,
      this.label = '',
      this.icon,
      this.labelColor,
      this.fillingColor = AppColors.greyscale50Color,
      this.hintText = '',
      this.obscureText,
      this.controller,
      this.validator,
      this.onSaved,
      this.onTap,
      this.autofocus = false,
      this.isEnabled = true,
      this.keyboardType,
      this.inputFormatters,
      this.labelText,
      this.filled = true,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16.sp,
              fontWeight: fontWeight ?? FontWeight.w400),
          enabled: isEnabled,
          obscuringCharacter: '⚫',
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: autovalidateMode,
          inputFormatters: inputFormatters,
          controller: controller,
          onTap: onTap,
          // maxLines: maxLines,
          obscureText: obscureText ?? false,
          // obscuringCharacter: '*',
          keyboardType: textInputType,
          validator: validator,
          onChanged: onSaved,
          // onChanged: (String value) {
          //   onSaved != null ? onSaved!() : null;
          // },
          decoration: InputDecoration(
            suffix: suffix,
            labelText: labelText,
            errorStyle: const TextStyle(color: AppColors.red),
            contentPadding:
                EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.5.w,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: fillingColor,
            filled: filled ?? false,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColors.greyscale400Color,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: BorderSide(
                    color: AppColors.greyscale50Color,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: BorderSide(
                    color: AppColors.greyscale50Color,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: BorderSide(
                    color: AppColors.red,
                    width: 0.5.w,
                    style: BorderStyle.solid)),
          ),
        ),
      ],
    );
  }
}
