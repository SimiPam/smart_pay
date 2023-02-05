import 'package:country_picker/country_picker.dart';
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
import '../../shared/widgets/custom_visibility_btn.dart';
import '../../shared/widgets/space.dart';

class IdentificationScreen extends StatelessWidget {
  const IdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      appBar: buildAppbar(context: context),
      body: Container(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            HSpace(20.h),
            Styles.richTextStyleTwo(
              text1: "Hey there! tell us a bit \nabout ",
              text2: "yourself",
              colorOne: AppColors.primaryColor,
              colorTwo: AppColors.secondaryColor,
              fontWeight: FWt.bold,
              fontWeightTwo: FWt.bold,
              fontSize: 24.sp,
              fontSizeTwo: 24.sp,
            ),
            HSpace(32.h),
            _signUpForm(viewModel, context),
            HSpace(30.h),
            CustomButton(
                margin: 0.w,
                title: 'Sign Up',
                isActive: true,
                nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                txtColor: AppColors.white,
                txtSize: 17.sp,
                fontWeight: FontWeight.normal,
                onPress: viewModel.validateSignUp),
            HSpace(30.h),
          ],
        ),
      ),
    );
  }

  Form _signUpForm(AuthViewModel viewModel, context) {
    return Form(
        key: viewModel.signUpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              hintText: 'Full Name',
              controller: viewModel.fNameController,
              validator: FieldValidator.validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            HSpace(16.h),
            CustomTextFormField(
              hintText: 'UserName',
              controller: viewModel.uNameController,
              validator: FieldValidator.validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            HSpace(16.h),
            InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    viewModel.selectCountry(country);
                  },
                  countryListTheme: CountryListThemeData(
                    bottomSheetHeight: deviceHeight(context) * 0.75,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                    backgroundColor: AppColors.white,
                    textStyle: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    inputDecoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      border: InputBorder.none,
                    ),
                    searchTextStyle: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                );
              },
              child: CustomTextFormField(
                hintText: 'Select Country',
                fontWeight: FontWeight.w600,
                controller: viewModel.countryController,
                isEnabled: false,
                validator: FieldValidator.validate,
              ),
            ),
            HSpace(16.h),
            CustomTextFormField(
                hintText: 'Password',
                controller: viewModel.passwordController,
                obscureText: !viewModel.passVisible!,
                validator: PasswordValidator.passwordvalidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffixIcon: PasswordVisibilityBtn(
                  onPress: () {
                    viewModel.hidePassword();
                  },
                  isVisible: viewModel.passVisible!,
                )),
          ],
        ));
  }
}
