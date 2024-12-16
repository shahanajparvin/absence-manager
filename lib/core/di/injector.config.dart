// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../domain/repository/absence_manager_repository.dart' as _i702;
import '../../domain/usecases/get_absences_usecase.dart' as _i237;
import '../../domain/usecases/get_members_usecase.dart' as _i627;
import '../../presentation/feature/absence/bloc/absence_bloc.dart' as _i1038;
import '../data/repository/absence_manager_repository_impl.dart' as _i1070;

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
    gh.lazySingleton<_i702.AbsenceManagerRepository>(
        () => _i1070.AbsenceManagerRepositoryImpl());
    gh.factory<_i237.GetAbsencesUseCase>(
        () => _i237.GetAbsencesUseCase(gh<_i702.AbsenceManagerRepository>()));
    gh.factory<_i627.GetMembersUseCase>(
        () => _i627.GetMembersUseCase(gh<_i702.AbsenceManagerRepository>()));
    gh.factory<_i1038.AbsenceBloc>(() => _i1038.AbsenceBloc(
          gh<_i1038.GetAbsencesUseCase>(),
          gh<_i627.GetMembersUseCase>(),
        ));
    return this;
  }
}
