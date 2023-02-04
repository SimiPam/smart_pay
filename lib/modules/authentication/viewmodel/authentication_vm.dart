// ignore_for_file: curly_braces_in_flow_control_structures, file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/base/base_viewmodel.dart';
import '../../../router/route_paths.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/utils/validator.dart';
import '../../../shared/widgets/custom_bottomsheet.dart';

class AuthViewModel extends BaseViewModel {
  final BuildContext? context;

  AuthViewModel({this.context});

  //form keys
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final createNewPasswordFormKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  //otp variables
  final FocusNode pinPutFocusNode = FocusNode();
  final TextEditingController pinPutController = TextEditingController();

  @override
  FutureOr<void> init() {}

  //text controllers
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController mNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController forgotPwdEmailController =
      TextEditingController();
  final TextEditingController signInpasswordController =
      TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController loginpasswordController = TextEditingController();
  final TextEditingController loginemailController = TextEditingController();

  String? message;

  bool isActive = false;
  bool passVisible = true;
  bool isChar = false;
  bool upperCase = false;
  bool lowerCase = false;
  bool isNumber = false;
  bool isSpecial = false;
  bool isSpaceContain = false;
  bool isPhoneValidated = false;
  bool isEmailValidated = false;
  bool isFNameValidated = false;
  bool isLNameValidated = false;

  // GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  String? confirmPassValidator(String? str) {
    if (str!.isEmpty) return 'This field can not be empty';
    if (confirmPwdCtrl.text.trim() != passwordController.text.trim())
      return 'Password do not match 🥲';

    return null;
  }

  void checkCharacter(String char) {
    if (char.length > 8 && char.length < 16) {
      isChar = true;
      notifyListeners();
    } else {
      isChar = false;
      notifyListeners();
    }
  }

  hidePassword() {
    passVisible = !passVisible;
    notifyListeners();
  }

  void togglePassword() {
    passVisible = !passVisible;
    notifyListeners();
  }

  validateEmailSignUp() {
    if (signUpFormKey.currentState!.validate()) {
      // save data
      signUpFormKey.currentState!.save();
      Navigator.pushNamed(context!, RoutePaths.otp);
      // navPush(context!, RoutePaths.enterPinScreen);
    }
  }

  validateSignUp() {
    if (signUpFormKey.currentState!.validate()) {
      // save data
      signUpFormKey.currentState!.save();
      // Navigator.pushNamed(context!, RoutePaths.otp);
      navPush(context!, RoutePaths.enterPinScreen);
    }
  }

  activateBtn(value) {
    if (EmailValidator.validateEmail(value) == null) {
      isActive = true;
    } else {
      isActive = false;
    }
    notifyListeners();
  }

  activateVerifyBtn(String value) {
    if (value.length == 5) {
      isActive = true;
    } else {
      isActive = false;
    }
    notifyListeners();
  }

  validateOTP(value) {
    navPush(context!, RoutePaths.identificationScreen);
  }

  validatePin(value) {
    navPush(context!, RoutePaths.confirmationScreen);
  }

  validateSignIn() {
    if (signInFormKey.currentState!.validate()) {
      // save data
      signInFormKey.currentState!.save();
      navPush(context!, RoutePaths.home);
      // Navigator.pushNamed(context!, RoutePaths.fipRequest);
    }
  }

  validateForgotPassword() {
    if (forgotPasswordFormKey.currentState!.validate()) {
      // save data
      forgotPasswordFormKey.currentState!.save();
      // Navigator.pushNamed(context!, RoutePaths.emailOtp);
    }
  }

  validateCreatingnewPassword() {
    if (createNewPasswordFormKey.currentState!.validate()) {
      // save data
      createNewPasswordFormKey.currentState!.save();
      showCustomModal(
          isSuccess: true,
          ctx: context!,
          buttonTextTwo: "Continue",
          headerText: 'Sucess!!',
          message:
              'Your account has been authenticated and  successfully linked on this application.',
          buttonText: 'Continue',
          callback: () {
            Navigator.of(context!).pop();
            // Navigator.pushNamed(context!, RoutePaths.signIn);
          });
    }
  }
}
