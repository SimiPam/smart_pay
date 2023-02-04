import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/authentication/viewmodel/authentication_vm.dart';
import 'package:smart_pay/modules/authentication/widgets/constant.dart';

import '../../router/route_paths.dart';
import '../../shared/utils/assets.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/styles.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textformfield.dart';
import '../../shared/widgets/custom_visibility_btn.dart';
import '../../shared/widgets/space.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppbar(context: context),
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Styles.medium('Hi There! 👋',
                  color: AppColors.primaryColor, fontSize: 24.sp),
              HSpace(8.h),
              Styles.regular('Welcome back, Sign in to your account',
                  color: AppColors.greyscaleTextColor, fontSize: 16.sp),
              HSpace(32.h),
              _signInForm(viewModel),
              HSpace(24.h),
              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, RoutePaths.forgotPassword);
                },
                child: Styles.medium('Forgot Password?',
                    fontSize: 16.sp, color: AppColors.secondaryColor),
              ),
              HSpace(24.h),
              CustomButton(
                  margin: 0.w,
                  title: 'Sign In',
                  isActive: true,
                  nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.3),
                  txtColor: AppColors.white,
                  txtSize: 16.sp,
                  fontWeight: FWt.bold,
                  onPress: viewModel.validateSignIn),
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
                    text1: "Don’t have an account? ",
                    text2: "Sign Up",
                    colorOne: AppColors.greyscaleTextColor,
                    colorTwo: AppColors.secondaryColor,
                    fontWeight: FWt.regular,
                    fontWeightTwo: FWt.mediumBold,
                    fontSize: 16.sp,
                    fontSizeTwo: 16.sp,
                    onTap: () {
                      navPush(context, RoutePaths.signUp);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _signInForm(AuthViewModel viewModel) {
    return Form(
        key: viewModel.signInFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              hintText: 'Email',
              controller: viewModel.signInEmailController,
              validator: FieldValidator.validate,
              fontWeight: FWt.mediumBold,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            HSpace(16.h),
            CustomTextFormField(
              hintText: 'Password',
              controller: viewModel.signInpasswordController,
              obscureText: !viewModel.passVisible,
              validator: FieldValidator.validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: PasswordVisibilityBtn(
                onPress: () {
                  viewModel.hidePassword();
                },
                isVisible: viewModel.passVisible,
              ),
            ),
          ],
        ));
  }
}
