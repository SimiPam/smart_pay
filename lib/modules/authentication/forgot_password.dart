import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/authentication/viewmodel/authentication_vm.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/styles.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textformfield.dart';
import '../../shared/widgets/space.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppbar(context: context, actions: []),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HSpace(50.h),
              Styles.regular('Forgot Password',
                  color: AppColors.primaryColor, fontSize: 24.sp),
              HSpace(12.h),
              Styles.regular(
                  'Enter the email associated with your account and we’ll send an OTP to reset you password.',
                  color: AppColors.black,
                  fontSize: 13.sp),
              HSpace(40.h),
              _forgotPasswordForm(viewModel),
              HSpace(30.h),
              CustomButton(
                  margin: 0.w,
                  title: 'Send Email',
                  isActive: true,
                  nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                  txtColor: AppColors.white,
                  txtSize: 17.sp,
                  fontWeight: FontWeight.normal,
                  onPress: viewModel.validateForgotPassword),
            ],
          ),
        ),
      ),
    );
  }

  Form _forgotPasswordForm(AuthViewModel viewModel) {
    return Form(
        key: viewModel.forgotPasswordFormKey,
        child: CustomTextFormField(
          hintText: 'Enter Email Address',
          controller: viewModel.forgotPwdEmailController,
          validator: EmailValidator.validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ));
  }
}
