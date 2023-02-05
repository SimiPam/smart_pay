// ignore_for_file: curly_braces_in_flow_control_structures, file_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/base/base_viewmodel.dart';
import '../../../core/service-injector/service_injector.dart';
import '../../../router/route_paths.dart';
import '../../../shared/models/api_model.dart';
import '../../../shared/models/authentication/auth_model.dart';
import '../../../shared/models/authentication/create_account_model.dart';
import '../../../shared/models/authentication/registration_model.dart';
import '../../../shared/models/authentication/verify_email_model.dart';
import '../../../shared/utils/assets.dart';
import '../../../shared/utils/color.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/utils/validator.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_snackbar.dart';
import '../../../shared/widgets/space.dart';

class AuthViewModel extends BaseViewModel {
  final BuildContext? context;
  final bool isSignIn;

  AuthViewModel({this.context, this.isSignIn = false});

  //form keys
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  //otp variables
  final FocusNode pinPutFocusNode = FocusNode();
  final TextEditingController pinPutController = TextEditingController();

  @override
  FutureOr<void> init() {
    getUserEmail();
    getUserName();
    if (isSignIn) {
      showBtmSheet(context);
    }
  }

  showBtmSheet(context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet<void>(
        context: context!,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.r),
          ),
        ),
        backgroundColor: AppColors.white,
        builder: (BuildContext context) {
          //Your builder code
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: deviceHeight(context) * 0.75,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Styles.medium('Enter PIN code',
                        color: AppColors.primaryColor, fontSize: 24.sp),
                    IconButton(
                      onPressed: () {
                        navPop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    )
                  ],
                ),
                HSpace(12.h),
                Styles.regular('Enter your pin to sign in.',
                    color: AppColors.greyscaleTextColor, fontSize: 16.sp),
                HSpace(32.h),
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  obscuringWidget: SvgPicture.asset(SvgAssets.obscureLogo),
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 44.h,
                      fieldWidth: 44.w,
                      activeFillColor: AppColors.primaryColor,
                      activeColor: AppColors.secondaryColor,
                      inactiveColor: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(3.r)),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  cursorColor: AppColors.otpBorderColor,
                  errorAnimationController: errorController,
                  controller: pinPutController,
                  onChanged: (value) {},
                  onCompleted: verifyInputPin,
                ),
                HSpace(44.h),
                CustomButton(
                    margin: 0.w,
                    title: 'Sign In',
                    isActive: true,
                    nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                    txtColor: AppColors.white,
                    txtSize: 17.sp,
                    fontWeight: FWt.bold,
                    onPress: () {
                      verifyInputPin(pinPutController.text);
                    }),
              ],
            ),
          );
        },
      );
    });
  }

  //text controllers
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController uNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String? _message;
  String _selectedCountry = "NG";
  String? get selectedCountry => _selectedCountry;
  String? _userPin;
  String? _userEmail;
  String _userName = "";
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  bool? _isActive = false;
  bool? get isActive => _isActive;
  bool? _passVisible = false;

  bool? get passVisible => _passVisible;

  hidePassword() {
    _passVisible = !_passVisible!;
    notifyListeners();
  }

  selectCountry(Country country) {
    countryController.text = "${country.flagEmoji} ${country.name}";
    _selectedCountry = country.countryCode;
    notifyListeners();
  }

  validateEmailSignUp() async {
    if (signUpFormKey.currentState!.validate()) {
      // save data
      signUpFormKey.currentState!.save();
      await createUser(context!, data: {'email': emailController.text});
      clearControllers();
    }
  }

  Future<String> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.brand;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        return iosDeviceInfo.name!;
      }
    } on PlatformException {
      return "mobile";
    }
    return "mobile";
  }

  getUserEmail() {
    final String email = si.storageService.getItemSync('userEmail');
    _userEmail = email;
    notifyListeners();
  }

  getUserName() {
    final String name = si.storageService.getItemSync('userName');
    _userName = name;
    notifyListeners();
  }

  validateSignUp() async {
    if (signUpFormKey.currentState!.validate()) {
      // save data
      signUpFormKey.currentState!.save();
      setLoadingState(true);
      await getUserEmail();
      String deviceName = await initPlatformState();

      await registerUser(context, {
        "full_name": fNameController.text,
        "username": uNameController.text,
        "email": _userEmail!,
        "country": _selectedCountry,
        "password": passwordController.text,
        "device_name": deviceName,
      });

      clearControllers();
    }
  }

  clearControllers() {
    fNameController.clear();
    uNameController.clear();
    emailController.clear();
    countryController.clear();
    passwordController.clear();
    _isActive = false;
  }

  activateBtn(value) {
    if (EmailValidator.validateEmail(value) == null) {
      _isActive = true;
    } else {
      _isActive = false;
    }
    notifyListeners();
  }

  activateVerifyBtn(String value) {
    if (value.length == 5) {
      _isActive = true;
    } else {
      _isActive = false;
    }
    notifyListeners();
  }

  validateOTP(value) async {
    await getUserEmail();
    debugPrint(_userEmail);
    await verifyEmail(context!, data: {"token": value, "email": _userEmail!});
    clearControllers();
  }

  validatePin(value) {
    si.storageService.setItem("userPin", value);
    navPushReplace(context!, RoutePaths.confirmationScreen);
  }

  retrievePin() {
    final String pin = si.storageService.getItemSync('userPin');
    _userPin = pin;
    // notifyListeners();
  }

  verifyInputPin(value) async {
    await retrievePin();
    if (value == _userPin) {
      navPop(context!);
      navPush(context!, RoutePaths.home);
    } else {
      snackBar(
          context: context!,
          message: "Oops! wrong pin, try again",
          isError: true,
          isbottomSheet: true);
      pinPutController.clear();
    }
  }

  validateSignIn() async {
    if (signInFormKey.currentState!.validate()) {
      // save data
      signInFormKey.currentState!.save();
      setLoadingState(true);
      String deviceName = await initPlatformState();
      await signInUser(context, {
        'email': emailController.text,
        'password': passwordController.text,
        'device_name': deviceName
      });
      clearControllers();
    }
  }

  persistData(res) {
    si.storageService.setItem('auth_data', json.encode(res.data!));
    // si.storageService.setItem('token', res.data!.data!.token!);
    si.storageService.setItem('userName', res.data!.data!.user!.username!);
    si.storageService.setItem('userFirstTime', json.encode(false));
  }

  String? getErrorMessage(res) {
    String msg = "Oops! try again";
    res.errors.forEach((key, value) {
      msg = "$msg \n${value[0]}";
    });
    return msg;
  }

  Future<void> createUser(BuildContext context,
      {required Map<String, String> data}) async {
    setLoadingState(true);

    try {
      final ApiResponse<CreateAccountPayload> res =
          await si.authService!.createAccount(data);
      if (res.status == false) {
        _message = getErrorMessage(res);
        snackBar(context: context, message: _message!, isError: true);

        setLoadingState(false);
      } else {
        _message = res.data!.data!.token!;
        debugPrint(res.data!.data!.token!);
        si.storageService.setItem('userEmail', data["email"]!);
        snackBar(context: context, message: _message!, isError: false);
        navPush(context!, RoutePaths.otp);
        setLoadingState(false);
      }
    } catch (e) {
      setLoadingState(false);
      _message = e.toString();
      debugPrint("error2 on catch block_______ $_message");
    }
  }

  Future<void> verifyEmail(BuildContext context,
      {required Map<String, String> data}) async {
    setLoadingState(true);

    try {
      final ApiResponse<VeriftyEmailPayload> res =
          await si.authService!.verifyEmail(data);
      if (res.status == false) {
        _message = getErrorMessage(res);
        snackBar(
            context: context, message: _message ?? "Wrong Pin", isError: true);

        setLoadingState(false);
      } else {
        _message = res.data!.message;
        si.storageService.setItem('userEmail', res.data!.data!.email!);
        snackBar(context: context, message: _message!, isError: false);
        navPushReplace(context!, RoutePaths.identificationScreen);
        setLoadingState(false);
      }
    } catch (e) {
      setLoadingState(false);
      _message = e.toString();
      debugPrint("error on catch block_______ $_message");
    }
  }

  Future<void> registerUser(
      BuildContext? context, Map<String, String> data) async {
    try {
      final ApiResponse<RegistrationPayload> res =
          await si.authService!.registerUser(data);
      data.clear();
      if (res.status == false) {
        _message = getErrorMessage(res);

        snackBar(context: context!, message: _message!, isError: true);
        setLoadingState(false);
      } else {
        _message = res.data!.message;
        si.storageService.removeItem("userEmail");
        persistData(res);
        snackBar(context: context!, message: _message!, isError: false);
        navPushReplace(context!, RoutePaths.enterPinScreen);
        setLoadingState(false);
      }
    } catch (e) {
      setLoadingState(false);
      _message = e.toString();
      snackBar(context: context!, message: "Please try again", isError: true);
      debugPrint("error on catch block_______ $_message");
    }
  }

  Future<void> signInUser(
      BuildContext? context, Map<String, String> data) async {
    try {
      final ApiResponse<AuthPayload> res =
          await si.authService!.signInUser(data);

      data.clear();
      if (res.status == false) {
        _message = getErrorMessage(res);
        snackBar(context: context!, message: _message!, isError: true);
        setLoadingState(false);
      } else {
        _message = res.data!.message;
        persistData(res);
        snackBar(context: context!, message: _message!, isError: false);
        navPush(context!, RoutePaths.home);
        setLoadingState(false);
      }
    } catch (e) {
      setLoadingState(false);
      _message = e.toString();
      snackBar(context: context!, message: "Please try again", isError: true);
      debugPrint("error on catch block_______ $_message");
    }
  }
}
