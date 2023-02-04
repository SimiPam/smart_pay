import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/authentication/viewmodel/authentication_vm.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textformfield.dart';
import '../../shared/widgets/space.dart';

class CreatenewPasswordScreen extends StatelessWidget {
  const CreatenewPasswordScreen({super.key});

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
      body: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HSpace(60.h),
                Styles.regular('Create New Password!',
                    color: AppColors.primaryColor, fontSize: 24.sp),
                HSpace(12.h),
                Styles.regular(
                    'Your new password must be different from previous used passwords.',
                    color: AppColors.black,
                    fontSize: 15.sp),
                HSpace(52.h),
                _passwordForm(viewModel),
                HSpace(30.h),
                CustomButton(
                    margin: 0.w,
                    title: 'Confirm',
                    isActive: true,
                    nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                    txtColor: AppColors.white,
                    txtSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    onPress: viewModel.validateCreatingnewPassword),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _passwordForm(AuthViewModel viewModel) {
    return Form(
        key: viewModel.createNewPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: 'Enter new password',
              controller: viewModel.passwordController,
              obscureText: !viewModel.passVisible,
              validator: PasswordValidator.passwordvalidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.hidePassword();
                  },
                  icon: viewModel.passVisible
                      ? const Icon(Icons.visibility,
                          color: AppColors.greyscaleTextColor)
                      : const Icon(Icons.visibility_off,
                          color: AppColors.greyscaleTextColor)),
            ),
            HSpace(20.h),
            CustomTextFormField(
              label: 'Confirm new password',
              controller: viewModel.confirmPwdCtrl,
              obscureText: !viewModel.passVisible,
              validator: viewModel.confirmPassValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.hidePassword();
                  },
                  icon: viewModel.passVisible
                      ? const Icon(Icons.visibility,
                          color: AppColors.greyscaleTextColor)
                      : const Icon(Icons.visibility_off,
                          color: AppColors.greyscaleTextColor)),
            ),
          ],
        ));
  }
}
