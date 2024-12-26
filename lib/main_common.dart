import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/flavor/flavor_config.dart';
import 'package:absence_manager/core/route/app_route.dart';
import 'package:absence_manager/core/utils/app_settings.dart';
import 'package:absence_manager/core/utils/app_theme.dart';
import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_bloc.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late AppLocalizations localizations;
late AppSettings appSettings;

Future<void> mainCommon(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  appSettings = await AppSettings.create();
  runApp(const MyApp());
}

Future<void> updateLocalization(Language language) async {
  localizations = await AppLocalizations.delegate.load(language.locale);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 947),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => BlocProvider<LanguageBloc>(
        create: (_) => LanguageBloc(appSettings.getSelectedLanguage()),
        child: const AppMaterial(),
      ),
    );
  }
}

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (BuildContext context, LanguageState state) => MaterialApp.router(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates:   const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: state.selectedLanguage.locale,
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
