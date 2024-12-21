import 'package:absence_manager/core/network/api_response.dart';
import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/domain/entities/member/member.dart';
import 'package:absence_manager/domain/usecases/get_absences_usecase.dart';
import 'package:absence_manager/domain/usecases/get_members_usecase.dart';
import 'package:absence_manager/presentation/feature/absence/adapter/absence_list_view_adapter.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:absence_manager/domain/usecases/get_absences_usecase.dart';


@Injectable()
class AbsenceListBloc extends Bloc<AbsenceListEvent, AbsenceListState> {
  final GetAbsencesUseCase _getAbsencesUseCase;
  final GetMembersUseCase _getMembersUseCase;

  List<AbsenceListModel>? _totalAbsences;
  bool _hasMorePages = false;

  AbsenceListBloc(this._getAbsencesUseCase, this._getMembersUseCase) : super(AbsenceInitial()) {
    on<GetAbsencesWithMembersEvent>(_onFetchAbsences);
    on<FetchPaginatedAbsenceEvent>(_onFetchPaginatedAbsences);
    on<FilterAbsencesEvent>(_onFilterAbsences);
    on<SearchAbsencesEvent>(_onSearchAbsences);
    on<ResetFiltersEvent>(_onResetFilters);
  }

  Future<void> _onFetchAbsences(
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
        final List<AbsenceListModel> list = await _adaptAbsencesData(absences.data!, members.data!);
        emit(AbsenceSuccessState(list));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }



  Future<void> _onFetchPaginatedAbsences(FetchPaginatedAbsenceEvent event, Emitter<AbsenceListState> emit) async {
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

        final int endIndex = startIndex + itemsToLoad;

        final List<Absence> paginatedAbsences = absences.data!.sublist(
            startIndex, endIndex > absences.data!.length ? absences.data!.length : endIndex);

        final List<AbsenceListModel> list =  _adaptAbsencesData(paginatedAbsences, members.data!);

        _hasMorePages = endIndex < absences.data!.length;

        List<AbsenceListModel> previousAbsences = <AbsenceListModel>[];

        if(state is AbsenceSuccessState){
          previousAbsences = (state as AbsenceSuccessState).absences;
        }
        final List<AbsenceListModel> totalAbsences = previousAbsences + list;
        _totalAbsences = totalAbsences;
         emit(AbsenceSuccessState(
          totalAbsences, // Add the new data to the existing list
          hasMorePages: _hasMorePages,
        ));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      debugPrint('stackTrace $stackTrace');
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }


  Future<void> _onFilterAbsences(
      FilterAbsencesEvent event, Emitter<AbsenceListState> emit) async {

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

        final List<Absence> filteredAbsences = _filterAbsences(
          absences:absences.data! ,
          type: event.type?.toLowerCase(),
          startDate: event.startDate,
          endDate: event.endDate
        );

        final List<AbsenceListModel> list =  _adaptAbsencesData(filteredAbsences, members.data!);

        emit(AbsenceSuccessState(list));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }


  Future<void> _onSearchAbsences(SearchAbsencesEvent event, Emitter<AbsenceListState> emit) async {
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


        final List<int> matchingUserIds = members.data!
            .where((Member member) => member.name.toLowerCase().contains(event.searchText.toLowerCase())) // Match by the dynamic search term
            .map((Member member) => member.userId) // Collect the userIds
            .toList();


        final List<Absence> filteredAbsences = absences.data!
            .where((Absence absence) => matchingUserIds.contains(absence.userId)) // Filter by userId
            .toList();


        final List<AbsenceListModel> list =  _adaptAbsencesData(filteredAbsences, members.data!);

        emit(AbsenceSuccessState(list));
      } else {
        final String errorMessage = _getErrorMessage(absences, members);
        emit(AbsenceErrorState(errorMessage));
      }
    } catch (e, stackTrace) {
      emit(AbsenceErrorState('An unexpected error occurred'));
    }
  }


  List<Absence> _filterAbsences({
    List<Absence> absences = const <Absence>[],
    String? startDate,
    String? endDate,
    String? type,
  }) {
    return absences.where((Absence absence) {
      final bool matchesStartDate = startDate == null || absence.startDate == startDate;
      final bool matchesEndDate = endDate == null || absence.endDate == endDate;
      final bool matchesType = type == null || type == 'all' || absence.type == type;

      return matchesStartDate && matchesEndDate && matchesType;
    }).toList();
  }


  void _onResetFilters(ResetFiltersEvent event, Emitter<AbsenceListState> emit) {
    if (_totalAbsences != null) {
      emit(AbsenceSuccessState(_totalAbsences!,hasMorePages: _hasMorePages));
    } else {
      emit(AbsenceErrorState('No previous data to restore.'));
    }
  }



  List<AbsenceListModel> _adaptAbsencesData(
      List<Absence> absences,
      List<Member> members)  {

    final AbsenceListViewAdapter adapter = AbsenceListViewAdapter(
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
