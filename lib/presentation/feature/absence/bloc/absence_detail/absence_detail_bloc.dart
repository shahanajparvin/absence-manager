import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/adapter/ansence_detail_view_adapter.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:absence_manager/domain/usecases/get_absences_usecase.dart';

export 'absence_detail_event.dart';
export 'absence_detail_state.dart';



@Injectable()
class AbsenceDetailBloc extends Bloc<AbsenceDetailEvent, AbsenceDetailState> {
  final GetAbsencesUseCase _getAbsencesUseCase;
  final GetMembersUseCase _getMembersUseCase;

  AbsenceDetailBloc(this._getAbsencesUseCase, this._getMembersUseCase) : super(AbsenceDetailInitial()) {
    on<FetchAbsenceDetailsEvent>(onFetchAbsenceDetails);
  }


  Future<void> onFetchAbsenceDetails(
      FetchAbsenceDetailsEvent event,
      Emitter<AbsenceDetailState> emit,
      ) async {
    try {
      emit(AbsenceDetailLoadingState()); // Emit loading state

      final List<ApiResponse<List<Object>>> responses = await Future.wait(<Future<ApiResponse<List<Object>>>>[
        _getAbsencesUseCase.execute(),
        _getMembersUseCase.execute(),
      ]);

      final ApiResponse<List<Absence>> absences = responses[0] as ApiResponse<List<Absence>>;
      final ApiResponse<List<Member>> members = responses[1] as ApiResponse<List<Member>>;

      if (absences is SuccessResponse<List<Absence>> && members is SuccessResponse<List<Member>>) {



        final Absence? absence= _findAbsenceById(absences.data!, event.absenceId);

        if(absence!=null){
          final Member? member = _findMemberById(members.data!, absence.userId);
          final AbsenceDetailModel absenceDetailsView = await _adaptAbsenceDetailData(absence, member!);
          emit(AbsenceDetailSuccessState(absenceDetailsView));
        }



      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceDetailErrorState(errorMessage));
      }

    } catch (e, stackTrace) {
      debugPrint('Error fetching absence details: $e');
      debugPrintStack(stackTrace: stackTrace);
      emit(AbsenceDetailErrorState('An unexpected error occurred'));
    }
  }


  Absence? _findAbsenceById(List<Absence> absences, int id) {
    return absences.firstWhere((Absence absence) => absence.id == id);
  }

  Member? _findMemberById(List<Member> members, int memberId) {
    return members.firstWhere((Member member) => member.userId == memberId);
  }


  AbsenceDetailModel _adaptAbsenceDetailData(
      Absence absence,
      Member member)  {

    final AbsenceDetailViewAdapter adapter = AbsenceDetailViewAdapter(
      absence: absence,
      member: member,
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
