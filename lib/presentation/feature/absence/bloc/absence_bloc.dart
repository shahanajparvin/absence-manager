import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:absence_manager/domain/usecases/get_absences_usecase.dart';

export 'absence_event.dart';
export 'absence_state.dart';




@Injectable()
class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final GetAbsencesUseCase _getAbsencesUseCase;
  final GetMembersUseCase _getMembersUseCase;

  AbsenceBloc(this._getAbsencesUseCase, this._getMembersUseCase) : super(AbsenceInitial()) {
    on<GetAbsencesEvent>(onGetAbsences);
  }

  Future<void> onGetAbsences(
      GetAbsencesEvent event, Emitter<AbsenceState> emit) async {

    emit(AbsenceLoadingState());

    final ApiResponse<List<Absence>> absences = await _getAbsencesUseCase.execute();

    final ApiResponse<List<Member>> members = await _getMembersUseCase.execute();

    if (absences is SuccessResponse<List<Absence>>) {
      emit(AbsenceSuccessState(absences.data!));
    } else if (absences is ErrorResponse) {
      emit(AbsenceErrorState((absences as ErrorResponse).errorMessage));
    }
  }
}
