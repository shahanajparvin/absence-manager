import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/adapter/absence_list_view_adapter.dart';
import 'package:absence_manager/presentation/feature/absence/adapter/ansence_detail_view_adapter.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_view.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:absence_manager/domain/usecases/get_absences_usecase.dart';





@Injectable()
class AbsenceListBloc extends Bloc<AbsenceListEvent, AbsenceListState> {
  final GetAbsencesUseCase _getAbsencesUseCase;
  final GetMembersUseCase _getMembersUseCase;

  AbsenceListBloc(this._getAbsencesUseCase, this._getMembersUseCase) : super(AbsenceInitial()) {
    on<GetAbsencesWithMembersEvent>(onFetchAbsences);
    on<FetchPaginatedAbsenceEvent>(onFetchPaginatedAbsences);
  }

  Future<void> onFetchAbsences(
      GetAbsencesWithMembersEvent event, Emitter<AbsenceListState> emit) async {
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
        final List<AbsenceListView> list = await _adaptAbsencesData(absences.data!, members.data!);
        emit(AbsenceSuccessState(list));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }





  Future<void> onFetchPaginatedAbsences(FetchPaginatedAbsenceEvent event, Emitter<AbsenceListState> emit) async {
    try {
      final List<ApiResponse<List<Object>>> responses = await Future.wait(<Future<ApiResponse<List<Object>>>>[
        _getAbsencesUseCase.execute(),
        _getMembersUseCase.execute(),
      ]);

      final ApiResponse<List<Absence>> absences = responses[0] as ApiResponse<List<Absence>>;
      final ApiResponse<List<Member>> members = responses[1] as ApiResponse<List<Member>>;

      if (absences is SuccessResponse<List<Absence>> && members is SuccessResponse<List<Member>>) {
        final int itemsToLoad = event.itemsPerPage;
        late int startIndex;


        if(state is AbsenceSuccessState){
          startIndex = (state as AbsenceSuccessState).absences.length;
        }else{
          startIndex = 0;
        }

        debugPrint('startIndex $startIndex');

        final int endIndex = startIndex + itemsToLoad;

        final List<Absence> paginatedAbsences = absences.data!.sublist(
            startIndex, endIndex > absences.data!.length ? absences.data!.length : endIndex);


        final List<AbsenceListView> list = await _adaptAbsencesData(paginatedAbsences, members.data!);



        final bool hasMorePages = endIndex < absences.data!.length;

        debugPrint('hasMorePages $hasMorePages');

        List<AbsenceListView> previousAbsences = [];

        if(state is AbsenceSuccessState){
          previousAbsences = (state as AbsenceSuccessState).absences;
        }
        final List<AbsenceListView> totalAbsences = previousAbsences + list;
        emit(AbsenceSuccessState(
          totalAbsences, // Add the new data to the existing list
          hasMorePages: hasMorePages,
        ));
        debugPrint('totalAbsences ${totalAbsences.length}');
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      debugPrint('stackTrace $stackTrace');
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }






  List<AbsenceListView> _adaptAbsencesData(
      List<Absence> absences,
      List<Member> members)  {

    final AbsenceListViewAdapter adapter = AbsenceListViewAdapter(
      absences: absences,
      members: members,
    );

    return adapter.adapt();  // Return the adapted list
  }

  AbsenceDetailView _adaptAbsenceDetailData(
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


  Future<void> onFetchAbsenceDetails(
      FetchAbsenceDetailsEvent event,
      Emitter<AbsenceListState> emit,
      ) async {
    try {
      emit(AbsenceLoadingState()); // Emit loading state

      final List<ApiResponse<List<Object>>> responses = await Future.wait(<Future<ApiResponse<List<Object>>>>[
        _getAbsencesUseCase.execute(),
        _getMembersUseCase.execute(),
      ]);

      final ApiResponse<List<Absence>> absences = responses[0] as ApiResponse<List<Absence>>;
      final ApiResponse<List<Member>> members = responses[1] as ApiResponse<List<Member>>;

      if (absences is SuccessResponse<List<Absence>> && members is SuccessResponse<List<Member>>) {



        final Absence? absence= _findAbsenceById(absences.data!, event.absenceId);

        if(absence!=null){
          final Member? member = _findMemberById(members.data!, absence.id);
          final AbsenceDetailView absenceDetailsView = await _adaptAbsenceDetailData(absence, member!);

        }



      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }

    } catch (e, stackTrace) {
      debugPrint('Error fetching absence details: $e');
      debugPrintStack(stackTrace: stackTrace);
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }


  Absence? _findAbsenceById(List<Absence> absences, int id) {
    return absences.firstWhere((Absence absence) => absence.id == id);
  }

  Member? _findMemberById(List<Member> members, int memberId) {
    return members.firstWhere((Member member) => member.userId == memberId);
  }


}
