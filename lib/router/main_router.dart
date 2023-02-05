import 'package:flutter/material.dart';
import 'package:smart_pay/modules/authentication/confirmation.dart';
import 'package:smart_pay/modules/authentication/create_pin.dart';
import 'package:smart_pay/modules/authentication/sign_in.dart';
import 'package:smart_pay/modules/authentication/sign_up.dart';
import 'package:smart_pay/modules/dashboard/home.dart';
import 'package:smart_pay/modules/onboarding/splash.dart';
import 'package:smart_pay/router/route_animation.dart';
import 'package:smart_pay/router/route_paths.dart';

import '../modules/authentication/email_otp.dart';
import '../modules/authentication/identification.dart';
import '../modules/onboarding/onboarding.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return TransitionalRouteFade(const SplashScreen());
      case RoutePaths.onboarding:
        return TransitionalRouteFade(const OnboardingScreen());

      case RoutePaths.signUp:
        return TransitionalRouteSlide(const SignUpScreen());

      case RoutePaths.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case RoutePaths.otp:
        return TransitionalRouteFade(const EmailOTPScreen());

      case RoutePaths.identificationScreen:
        return TransitionalRouteFade(const IdentificationScreen());

      case RoutePaths.enterPinScreen:
        return TransitionalRouteFade(const EnterPinScreen());

      case RoutePaths.confirmationScreen:
        return TransitionalRouteFade(const ConfirmationScreen());

      case RoutePaths.home:
        return TransitionalRouteFade(const HomeScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
