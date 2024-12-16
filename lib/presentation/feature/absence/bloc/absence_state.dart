import 'package:absence_manager/domain/entities/absence/absence.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_view.dart';

abstract class AbsenceState {}

class AbsenceInitial extends AbsenceState {}

class AbsenceLoadingState extends AbsenceState {}

class AbsenceSuccessState extends AbsenceState {
  final List<AbsenceListView> absences;
  final bool hasMorePages;

  AbsenceSuccessState(this.absences, {this.hasMorePages = false});
}

class AbsenceErrorState extends AbsenceState {
  final String errorMessage;

  AbsenceErrorState(this.errorMessage);
}
