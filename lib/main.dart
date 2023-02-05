import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:smart_pay/router/main_router.dart';
import 'package:smart_pay/router/route_paths.dart';
import 'package:smart_pay/shared/utils/color.dart';
import 'package:smart_pay/shared/utils/utils.dart';

import 'core/service-injector/service_injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RouteObserverProvider(
    child: const MyApp(
      appKey: ValueKey<String>('root'),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({this.appKey}) : super(key: appKey);
  final ValueKey<String>? appKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _init();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ),
    );

    // // The preferred screen orientation
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]).then((_) {});
    super.initState();
  }

  Future<void> _init() async {
    await si.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(logicalWidth(), logicalHeight()),
      builder: (context, Widget? child) => MaterialApp(
        title: 'SmartPay',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.splash,
        onGenerateRoute: MainRouter.generateRoute,
        theme: ThemeData(
          backgroundColor: AppColors.white,
          fontFamily: 'sf-pro-display',
        ),
      ),
      // ),
    );
  }
}
