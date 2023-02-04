import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_pay/shared/utils/assets.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/space.dart';
import 'viewmodel/authentication_vm.dart';

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({super.key});

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
                  Styles.medium('Set your PIN code',
                      color: AppColors.primaryColor, fontSize: 24.sp),
                  HSpace(12.h),
                  Styles.regular(
                      'We use state-of-the-art security measures to protect your information at all times',
                      color: AppColors.greyscaleTextColor,
                      fontSize: 16.sp),
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
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    cursorColor: AppColors.otpBorderColor,
                    // enableActiveFill: true,
                    errorAnimationController: viewModel.errorController,
                    controller: viewModel.pinPutController,
                    onChanged: viewModel.activateVerifyBtn,
                    onCompleted: viewModel.validatePin,
                    beforeTextPaste: (text) {
                      // print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  HSpace(44.h),
                  CustomButton(
                      margin: 0.w,
                      title: 'Create PIN',
                      isActive: viewModel.isActive,
                      nonActiveBtnColor:
                          AppColors.primaryColor.withOpacity(0.4),
                      txtColor: AppColors.white,
                      txtSize: 17.sp,
                      fontWeight: FWt.bold,
                      onPress: () {
                        viewModel.validatePin(viewModel.pinPutController.text);
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

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
