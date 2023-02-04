import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/modules/onboarding/viewmodel/onboarding_vm.dart';
import 'package:smart_pay/modules/onboarding/widgets/onboarding_content.dart';

import '../../router/route_paths.dart';
import '../../shared/utils/assets.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/space.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  const OnBoardingScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardingViewModel>(
        vmBuilder: (context) => OnBoardingViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, OnBoardingViewModel viewModel) {
    return Scaffold(
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        child: Stack(
          children: [
            PageView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: viewModel.controller,
                onPageChanged: (value) {
                  viewModel.updatePageIndex(value);
                },
                itemCount: viewModel.slides.length,
                itemBuilder: (context, index) {
                  return OnboardingImages(
                      image: viewModel.slides[index].fgImage);
                }),
            HSpace(30.h),
            // Expanded(
            //   child: PageView.builder(
            //       physics: const ClampingScrollPhysics(),
            //       scrollDirection: Axis.horizontal,
            //       controller: viewModel.controller,
            //       onPageChanged: (value) {
            //         viewModel.updatePageIndex(value);
            //       },
            //       itemCount: viewModel.slides.length,
            //       itemBuilder: (context, index) {
            //         return OnboardingImages(
            //             image: viewModel.slides[index].image);
            //       }),
            // ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HSpace(46.h),
                      OnboardingText(
                        headerText: viewModel
                            .slidesContent[viewModel.contentIndex!].headerText,
                        subTitle: viewModel
                            .slidesContent[viewModel.contentIndex!]
                            .paragraphText,
                      ),
                      HSpace(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          viewModel.slides.length,
                          (index) => buildDot(index, context, viewModel),
                        ),
                      ),
                      HSpace(34.h),
                      CustomButton(
                          margin: 20.w,
                          title: 'Get Started',
                          isActive: true,
                          btnColor: AppColors.primaryColor,
                          txtColor: AppColors.white,
                          txtSize: 16.sp,
                          fontWeight: FWt.bold,
                          onPress: () {
                            Navigator.pushNamed(context, RoutePaths.signUp);
                          }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // container created for dots
  Container buildDot(
      int index, BuildContext context, OnBoardingViewModel viewModel) {
    return Container(
      height: viewModel.currentIndex == index ? 6.h : 6.h,
      width: viewModel.currentIndex == index ? 32.w : 6.w,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // shape: BoxShape.circle,
        color: viewModel.currentIndex == index
            ? AppColors.primaryColor
            : AppColors.greyscaleColor,
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardingViewModel>(
        vmBuilder: (context) => OnBoardingViewModel(context: context),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, OnBoardingViewModel viewModel) {
    return Scaffold(
      appBar: buildAppbar(context: context, isOnboarding: true),
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        child: Stack(
          children: [
            Positioned(
              top: deviceHeight(context) * 0.054,
              left: deviceWidth(context) * 0.165,
              child: SvgPicture.asset(
                SvgAssets.onboardOne,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(
                            5.0,
                            0.0,
                          ),
                          blurRadius: 30.0,
                          spreadRadius: 80.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(5, 0),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.5),
                          Colors.white,
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: viewModel.controller,
                      onPageChanged: (value) {
                        viewModel.updatePageIndex(value);
                      },
                      itemCount: viewModel.slides.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HSpace(65.h),
                            SvgPicture.asset(viewModel.slides[index].fgImage),
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 44.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Styles.medium(
                          viewModel.slidesContent[viewModel.contentIndex!]
                              .headerText,
                          fontSize: 24.sp,
                          color: AppColors.primaryColor,
                          align: TextAlign.center,
                        ),
                        HSpace(16.h),
                        Styles.regular(
                          viewModel.slidesContent[viewModel.contentIndex!]
                              .paragraphText,
                          fontSize: 14.sp,
                          color: AppColors.greyscaleTextColor,
                          align: TextAlign.center,
                        ),
                        HSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            viewModel.slides.length,
                            (index) => buildDot(index, context, viewModel),
                          ),
                        ),
                        HSpace(34.h),
                        CustomButton(
                            margin: 20.w,
                            title: 'Get Started',
                            isActive: true,
                            btnColor: AppColors.primaryColor,
                            txtColor: AppColors.white,
                            txtSize: 16.sp,
                            fontWeight: FWt.bold,
                            onPress: () {
                              Navigator.pushNamed(context, RoutePaths.signUp);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // container created for dots
  Container buildDot(
      int index, BuildContext context, OnBoardingViewModel viewModel) {
    return Container(
      height: viewModel.currentIndex == index ? 6.h : 6.h,
      width: viewModel.currentIndex == index ? 32.w : 6.w,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // shape: BoxShape.circle,
        color: viewModel.currentIndex == index
            ? AppColors.primaryColor
            : AppColors.greyscaleColor,
      ),
    );
  }
}

// */
