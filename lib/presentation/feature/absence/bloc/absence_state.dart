import 'package:absence_manager/domain/entities/absence/absence.dart';

abstract class AbsenceState {}

class AbsenceInitial extends AbsenceState {}

class AbsenceLoadingState extends AbsenceState {}

class AbsenceSuccessState extends AbsenceState {
  final List<Absence> absences;

  AbsenceSuccessState(this.absences);
}

class AbsenceErrorState extends AbsenceState {
  final String errorMessage;

  AbsenceErrorState(this.errorMessage);
}
