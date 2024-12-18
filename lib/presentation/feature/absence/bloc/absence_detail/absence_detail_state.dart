import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';

abstract class AbsenceDetailState {}

class AbsenceDetailInitial extends AbsenceDetailState {}

class AbsenceDetailLoadingState extends AbsenceDetailState {}

class AbsenceDetailSuccessState extends AbsenceDetailState {
  AbsenceDetailModel absenceDetailView;


  AbsenceDetailSuccessState(this.absenceDetailView);
}

class AbsenceDetailErrorState extends AbsenceDetailState {
  final String errorMessage;

  AbsenceDetailErrorState(this.errorMessage);
}
