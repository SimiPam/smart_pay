import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/authentication/viewmodel/authentication_vm.dart';
import 'package:smart_pay/modules/authentication/widgets/constant.dart';
import 'package:smart_pay/router/route_paths.dart';
import 'package:smart_pay/shared/utils/assets.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/styles.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textformfield.dart';
import '../../shared/widgets/space.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      appBar: buildAppbar(context: context),
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Styles.richTextStyle(
                    text1: "Create a ",
                    text2: "Smartpay ",
                    text3: "\naccount",
                    colorOne: AppColors.primaryColor,
                    colorTwo: AppColors.secondaryColor,
                    colorThree: AppColors.primaryColor,
                    fontWeight: FWt.mediumBold,
                    fontWeightTwo: FWt.mediumBold,
                    fontWeightThree: FWt.mediumBold,
                    fontSize: 24.sp,
                    fontSizeTwo: 24.sp,
                    fontSizeThree: 24.sp,
                  ),
                  HSpace(32.h),
                  Form(
                    key: viewModel.signUpFormKey,
                    child: CustomTextFormField(
                      hintText: 'Email Address',
                      controller: viewModel.emailController,
                      validator: EmailValidator.validateEmail,
                      onSaved: viewModel.activateBtn,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  HSpace(24.h),
                  CustomButton(
                      margin: 0.w,
                      title: 'Sign Up',
                      isActive: viewModel.isActive,
                      nonActiveBtnColor:
                          AppColors.primaryColor.withOpacity(0.3),
                      txtColor: AppColors.white,
                      txtSize: 16.sp,
                      fontWeight: FWt.bold,
                      onPress: viewModel.validateEmailSignUp),
                  HSpace(32.h),
                  Row(
                    children: [
                      const Flexible(child: Divider()),
                      WSpace(12.w),
                      Styles.regular("OR",
                          color: AppColors.greyscaleTextColor, fontSize: 14.sp),
                      WSpace(12.w),
                      const Flexible(child: Divider()),
                    ],
                  ),
                  HSpace(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: socialMediaLogin(SvgAssets.googleLogo, context),
                      ),
                      WSpace(16.w),
                      Flexible(
                        child: socialMediaLogin(SvgAssets.appleLogo, context),
                      ),
                    ],
                  ),
                  HSpace(117.h),
                  Center(
                    child: Styles.richTextStyleTwo(
                        text1: "Already have an account? ",
                        text2: "Sign In",
                        colorOne: AppColors.greyscaleTextColor,
                        colorTwo: AppColors.secondaryColor,
                        fontWeight: FWt.regular,
                        fontWeightTwo: FWt.mediumBold,
                        fontSize: 16.sp,
                        fontSizeTwo: 16.sp,
                        onTap: () {
                          navPush(context, RoutePaths.signIn);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
