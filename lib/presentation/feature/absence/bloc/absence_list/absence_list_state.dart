import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';

abstract class AbsenceListState {}

class AbsenceInitial extends AbsenceListState {}

class AbsenceLoadingState extends AbsenceListState {}

class AbsenceSuccessState extends AbsenceListState {
  final List<AbsenceListView> absences;
  final bool hasMorePages;

  AbsenceSuccessState(this.absences, {this.hasMorePages = false});
}

class AbsenceErrorState extends AbsenceListState {
  final String errorMessage;

  AbsenceErrorState(this.errorMessage);
}
