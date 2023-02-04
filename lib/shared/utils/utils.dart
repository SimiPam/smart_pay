// ignore_for_file: unnecessary_null_comparison, null_check_always_fails

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../router/main_router.dart';

export 'dims.dart';
export 'styles.dart';

// ignore: constant_identifier_names
enum ViewState { IDLE, BUSY, RETRIEVED, ERROR }

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

///design height(responsiveness)
double logicalHeight() {
  return WidgetsBinding.instance.window.physicalSize.height /
      WidgetsBinding.instance.window.devicePixelRatio;
}

///design width(responsiveness)
double logicalWidth() {
  return WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

navPush(BuildContext context, String route) {
  Navigator.push(context, MainRouter.generateRoute(RouteSettings(name: route)));
}

navPushReplace(BuildContext context, String route) {
  Navigator.pushReplacement(
      context, MainRouter.generateRoute(RouteSettings(name: route)));
}

navPop(BuildContext context) {
  Navigator.pop(context);
}

class FormUtils {
  FormUtils._();

  static bool isValidEmail(String email) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneValid = RegExp(r"0[789][01]\d{8}").hasMatch(phoneNumber);

    return phoneValid;
  }

  static bool hasDigits(String text) {
    final hasDigits = text.contains(RegExp(r'[0-9]'));
    return hasDigits;
  }

  static bool hasUppercase(String text) {
    final hasUppercase = text.contains(RegExp(r'[A-Z]'));
    return hasUppercase;
  }

  static bool hasLowercase(String text) {
    final hasLowercase = text.contains(RegExp(r'[a-z]'));
    return hasLowercase;
  }

  static bool hasSpecialCharacters(String text) {
    final hasSpecialCharacters =
        text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasSpecialCharacters;
  }

  static bool hasMinLength(String text, {int minLength = 8}) {
    final hasMinLength = text.length >= minLength;
    return hasMinLength;
  }
}
