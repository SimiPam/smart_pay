import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../router/route_paths.dart';
import '../../shared/utils/assets.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    const duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    bool? isUserFirstTime = false;
    var output = prefs!.getString('userFirstTime');
    if (output != null) {
      isUserFirstTime = json.decode(output!);
      debugPrint(isUserFirstTime.toString());
      if (isUserFirstTime!) {
        navPushReplace(context!, RoutePaths.onboarding);
      } else {
        navPushReplace(context!, RoutePaths.signIn);
      }
    } else {
      navPushReplace(context!, RoutePaths.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: logicalHeight(),
        width: logicalWidth(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgAssets.logo,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
