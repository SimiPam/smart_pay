import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/base/base_viewmodel.dart';
import '../../../shared/models/onboarding/onboarding_model.dart';
import '../../../shared/utils/assets.dart';

class OnBoardingViewModel extends BaseViewModel {
  final BuildContext context;

  OnBoardingViewModel({required this.context});

  int _currentIndex = 0;
  PageController? _controller;
  Timer? _pageAnimationTimer;
  int? _contentIndex = 0;

  int get currentIndex => _currentIndex;
  int? get contentIndex => _contentIndex;
  PageController? get controller => _controller;

  List<OnboardingModel> slides = [
    OnboardingModel(
        fgImage: SvgAssets.illustrationLogo, bgImage: SvgAssets.onboardOne),
    OnboardingModel(
        fgImage: SvgAssets.illustrationTwoLogo, bgImage: SvgAssets.onboardTwo),
  ];

  List<OnboardingContentModel> slidesContent = [
    OnboardingContentModel(
        paragraphText:
            "Your finance work starts here. Our here to help you track and deal with speeding up\nyour transactions.",
        headerText: "Finance app the safest\nand most trusted"),
    OnboardingContentModel(
        paragraphText:
            "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
        headerText: "The fastest transaction\nprocess only here"),
  ];

  @override
  FutureOr<void> init() {
    _pageAnimationTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      animatePages();
    });
    _controller = PageController(initialPage: 0);
  }

  animatePages() {
    if (_controller == null) return;
    if (_currentIndex < 2) {
      _controller!.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }

  updatePageIndex(int index) {
    _currentIndex = index;
    _contentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _pageAnimationTimer!.cancel();
    _pageAnimationTimer = null;
    _controller!.dispose();
    super.dispose();
  }
}
