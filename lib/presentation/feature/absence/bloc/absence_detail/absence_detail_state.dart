import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class AbsenceDetailState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class AbsenceDetailInitial extends AbsenceDetailState {}

class AbsenceDetailLoadingState extends AbsenceDetailState {}

class AbsenceDetailSuccessState extends AbsenceDetailState {
  final AbsenceDetailModel absenceDetailView;

  AbsenceDetailSuccessState(this.absenceDetailView);

  @override
  List<Object?> get props => <Object?>[absenceDetailView];
}

class AbsenceDetailErrorState extends AbsenceDetailState {
  final String errorMessage;

  AbsenceDetailErrorState(this.errorMessage);

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
