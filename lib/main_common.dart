import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/flavor/flavor_config.dart';
import 'package:absence_manager/core/route/app_route.dart';
import 'package:absence_manager/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> mainCommon(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth != 0&&constraints.maxHeight!=0) {
          return ScreenUtilInit(
            designSize: const Size(375, 947),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, Widget? child) => _buildMaterialApp(),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp.router(
        localizationsDelegates: const <LocalizationsDelegate>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('de', 'DE'),
        theme: appTheme,
        routerConfig: router
    );
  }
}



