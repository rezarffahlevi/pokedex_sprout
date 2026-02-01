import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/app.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/utils/pokedex_bootstrap.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: true,
        ),
      );
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        log('FlutterError.onError $details');
      };

      await initInjection();
      // WidgetsBinding.instance.addObserver(inject<AppLifecycleHandler>());

      return runApp(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          enableScaleText: () => true,
          builder: (context, child) {
            return const App();
          },
        ),
      );
    },
    (error, stackTrace) {
      log('runZonedGuarded.onError $error');
    },
  );
}
