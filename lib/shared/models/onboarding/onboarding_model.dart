class OnboardingModel {
  final String fgImage;
  final String bgImage;

  OnboardingModel({
    required this.bgImage,
    required this.fgImage,
  });
}

class OnboardingContentModel {
  final String headerText;
  final String paragraphText;

  OnboardingContentModel(
      {required this.headerText, required this.paragraphText});
}
