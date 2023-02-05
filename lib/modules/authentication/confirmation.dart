import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/modules/authentication/viewmodel/authentication_vm.dart';
import 'package:smart_pay/router/route_paths.dart';
import 'package:smart_pay/shared/utils/assets.dart';
import 'package:smart_pay/shared/utils/color.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_button.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen();

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;

  @override
  void initState() {
    // TODO: implement initState

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.easeIn,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        vmBuilder: (context) => AuthViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        child: Stack(
          children: [
            Positioned(
              top: 200.h,
              right: 24.w,
              left: 24.w,
              child: SlideTransition(
                position: _offsetAnimation!,
                child: Image.asset(
                  ImageAssets.confirmLogo,
                  width: 140.45.w,
                  height: 134.33.h,
                ),
              ),
            ),
            Positioned(
              top: 350.h,
              right: 24.w,
              left: 24.w,
              child: SlideTransition(
                position: _offsetAnimation!,
                child: Styles.bold("Congratulations, ${viewModel.userName!}",
                    align: TextAlign.center, color: AppColors.primaryColor),
              ),
            ),
            Positioned(
              top: 400.h,
              right: 24.w,
              left: 24.w,
              child: SlideTransition(
                position: _offsetAnimation!,
                child: Styles.regular(
                    'You’ve completed the onboarding,\nyou can start using',
                    color: AppColors.greyscaleTextColor,
                    align: TextAlign.center,
                    fontSize: 16.sp),
              ),
            ),
            Positioned(
              top: 482.h,
              right: 24.w,
              left: 24.w,
              child: SlideTransition(
                position: _offsetAnimation!,
                child: CustomButton(
                    margin: 0.w,
                    title: 'Get Started',
                    isActive: true,
                    nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                    txtColor: AppColors.white,
                    txtSize: 17.sp,
                    fontWeight: FWt.bold,
                    onPress: () {
                      navPushReplace(context, RoutePaths.home);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
