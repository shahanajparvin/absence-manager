
import 'package:absence_manager/core/di/injector.config.dart';
import 'package:api/api.dart';
import 'package:api/api_imp.dart';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

Future<GetIt> configureDependencies() async => injector.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @lazySingleton
  Api get api => ApiImpl();

}

