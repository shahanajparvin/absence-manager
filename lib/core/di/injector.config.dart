// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:api/api.dart' as _i24;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/repository/absence_manager_repository_impl.dart' as _i114;
import '../../domain/repository/absence_manager_repository.dart' as _i702;
import '../../domain/usecases/get_absences_usecase.dart' as _i237;
import '../../domain/usecases/get_members_usecase.dart' as _i627;
import '../../presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart'
    as _i775;
import '../../presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart'
    as _i286;
import '../../presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart'
    as _i846;
import '../network/api_exceptions.dart' as _i978;
import '../service/app_dialog_service.dart' as _i513;
import '../service/filter_handler_service.dart' as _i1034;
import '../utils/app_modal_controller.dart' as _i553;
import '../utils/app_settings.dart' as _i270;
import 'injector.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i978.ApiExceptionHandlingService>(
        () => _i978.ApiExceptionHandlingService());
    gh.factory<_i513.AppDialogService>(() => _i513.AppDialogService());
    gh.factory<_i553.ModalController>(() => _i553.ModalController());
    gh.factory<_i846.AbsenceFilterDataBloc>(
        () => _i846.AbsenceFilterDataBloc());
    gh.lazySingletonAsync<_i460.SharedPreferences>(
        () => registerModule.sharedPreferences);
    gh.lazySingleton<_i24.Api>(() => registerModule.api);
    gh.factory<_i1034.FilterHandler>(
        () => _i1034.FilterHandler(gh<_i513.AppDialogService>()));
    gh.factoryAsync<_i270.AppSettings>(() async =>
        _i270.AppSettings(await getAsync<_i460.SharedPreferences>()));
    gh.lazySingleton<_i702.AbsenceManagerRepository>(
        () => _i114.AbsenceManagerRepositoryImpl(
              gh<_i24.Api>(),
              gh<_i978.ApiExceptionHandlingService>(),
            ));
    gh.factory<_i237.GetAbsencesUseCase>(
        () => _i237.GetAbsencesUseCase(gh<_i702.AbsenceManagerRepository>()));
    gh.factory<_i627.GetMembersUseCase>(
        () => _i627.GetMembersUseCase(gh<_i702.AbsenceManagerRepository>()));
    gh.factory<_i286.AbsenceListBloc>(() => _i286.AbsenceListBloc(
          gh<_i286.GetAbsencesUseCase>(),
          gh<_i627.GetMembersUseCase>(),
        ));
    gh.factory<_i775.AbsenceDetailBloc>(() => _i775.AbsenceDetailBloc(
          gh<_i775.GetAbsencesUseCase>(),
          gh<_i627.GetMembersUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i811.RegisterModule {}
