import 'package:flutter/material.dart';
import 'package:smart_pay/modules/authentication/confirmation.dart';
import 'package:smart_pay/modules/authentication/enter_pin.dart';
import 'package:smart_pay/modules/authentication/sign_in.dart';
import 'package:smart_pay/modules/authentication/sign_up.dart';
import 'package:smart_pay/modules/dashboard/home.dart';
import 'package:smart_pay/modules/onboarding/splash.dart';
import 'package:smart_pay/router/route_paths.dart';

import '../modules/authentication/email_otp.dart';
import '../modules/authentication/identification.dart';
import '../modules/onboarding/onboarding_page.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        break;
      case RoutePaths.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        break;
      case RoutePaths.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
        break;
      case RoutePaths.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
        break;
      case RoutePaths.otp:
        return MaterialPageRoute(builder: (_) => const EmailOTPScreen());
        break;
      case RoutePaths.identificationScreen:
        return MaterialPageRoute(builder: (_) => const IdentificationScreen());
        break;
      case RoutePaths.enterPinScreen:
        return MaterialPageRoute(builder: (_) => const EnterPinScreen());
        break;
      case RoutePaths.confirmationScreen:
        return MaterialPageRoute(builder: (_) => const ConfirmationScreen());
        break;
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        break;
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
