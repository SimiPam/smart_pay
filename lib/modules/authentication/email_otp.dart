import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/count_down.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/space.dart';
import 'viewmodel/authentication_vm.dart';

class EmailOTPScreen extends StatefulWidget {
  const EmailOTPScreen({super.key});

  @override
  State<EmailOTPScreen> createState() => _EmailOTPScreenState();
}

class _EmailOTPScreenState extends State<EmailOTPScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  int levelClock = 30;
  late AnimationController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: buildAppbar(context: context),
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HSpace(20.h),
                  Styles.medium('Verify it’s you',
                      color: AppColors.primaryColor, fontSize: 24.sp),
                  HSpace(12.h),
                  Styles.richTextStyle(
                    text1: "We send a code to ( ",
                    text2: "*****@mail.com ",
                    text3: "). Enter it here to verify your identity",
                    colorOne: AppColors.greyscaleTextColor,
                    colorTwo: AppColors.primaryColor,
                    colorThree: AppColors.greyscaleTextColor,
                    fontWeight: FWt.regular,
                    fontWeightTwo: FWt.semiBold,
                    fontWeightThree: FWt.regular,
                    fontSize: 16.sp,
                    fontSizeTwo: 16.sp,
                    fontSizeThree: 16.sp,
                  ),
                  HSpace(32.h),
                  PinCodeTextField(
                    appContext: context,
                    length: 5,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    showCursor: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 56.h,
                        fieldWidth: 56.w,
                        selectedColor: AppColors.otpBorderColor,
                        selectedFillColor: AppColors.greyscale50Color,
                        errorBorderColor: AppColors.red,

                        // activeFillColor: AppColors.red,
                        borderWidth: 1,
                        inactiveFillColor: AppColors.greyscale50Color,
                        activeFillColor: AppColors.greyscale50Color,
                        activeColor: AppColors.otpBorderColor,
                        inactiveColor: AppColors.greyscale50Color,
                        borderRadius: BorderRadius.circular(12.r)),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: AppColors.white,
                    cursorColor: AppColors.primaryColor,
                    enableActiveFill: true,
                    errorAnimationController: viewModel.errorController,
                    controller: viewModel.pinPutController,
                    onChanged: viewModel.activateVerifyBtn,
                    onCompleted: viewModel.validateOTP,
                    beforeTextPaste: (text) {
                      // print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  HSpace(32.h),
                  // Center(
                  //   child: Styles.bold('Resend Code 30 secs',
                  //       color: AppColors.greyscale600Color, fontSize: 16.sp),
                  // ),
                  Countdown(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_controller),
                  ),
                  HSpace(67.h),
                  CustomButton(
                      margin: 0.w,
                      title: 'Confirm',
                      isActive: viewModel.isActive,
                      nonActiveBtnColor:
                          AppColors.primaryColor.withOpacity(0.4),
                      txtColor: AppColors.white,
                      txtSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      onPress: () {
                        viewModel.validateOTP(viewModel.pinPutController.text);
                        // Navigator.pushNamed(context, RoutePaths.createPassword);
                      }),
                  HSpace(40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
