
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';

import 'package:equatable/equatable.dart';


abstract class AbsenceListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class AbsenceInitial extends AbsenceListState {}

class AbsenceLoadingState extends AbsenceListState {}

class AbsenceSuccessState extends AbsenceListState {
  final List<AbsenceListModel> absences;
  final bool hasMorePages;

  AbsenceSuccessState(this.absences, {this.hasMorePages = false});

  @override
  List<Object?> get props => <Object?>[absences, hasMorePages];
}

class AbsenceErrorState extends AbsenceListState {
  final String errorMessage;

  AbsenceErrorState(this.errorMessage);

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

