import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/adapter/absence_view_adapter.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_view.dart';
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
    on<GetAbsencesWithMembersEvent>(onGetAbsencesWithMembers);
  }

  Future<void> onGetAbsencesWithMembers(
      GetAbsencesWithMembersEvent event, Emitter<AbsenceState> emit) async {
    emit(AbsenceLoadingState());

    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      final List<ApiResponse<List<Object>>> responses = await Future.wait(<Future<ApiResponse<List<Object>>>>[
        _getAbsencesUseCase.execute(),
        _getMembersUseCase.execute(),
      ]);

      final ApiResponse<List<Absence>> absences = responses[0] as ApiResponse<List<Absence>>;
      final ApiResponse<List<Member>> members = responses[1] as ApiResponse<List<Member>>;

      if (absences is SuccessResponse<List<Absence>> && members is SuccessResponse<List<Member>>) {
        final List<AbsenceView> list = await _adaptAbsencesData(absences.data!, members.data!);
        emit(AbsenceSuccessState(list));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }


  Future<List<AbsenceView>> _adaptAbsencesData(
      List<Absence> absences,
      List<Member> members) async {

    final AbsenceAdapter adapter = AbsenceAdapter(
      absences: absences,
      members: members,
    );

    return adapter.adapt();  // Return the adapted list
  }


  String _getErrorMessage(
      ApiResponse<List<Absence>> absences,
      ApiResponse<List<Member>> members) {
    if (absences is ErrorResponse) {
      return (absences as ErrorResponse).errorMessage;
    } else if (members is ErrorResponse) {
      return(members as ErrorResponse).errorMessage;
    } else {
      return 'Unknown error';
    }
  }

}
