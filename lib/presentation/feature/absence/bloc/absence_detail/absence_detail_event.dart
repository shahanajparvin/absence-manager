

abstract class AbsenceDetailEvent {}


class FetchAbsenceDetailsEvent extends AbsenceDetailEvent {
  final int absenceId;
  FetchAbsenceDetailsEvent(this.absenceId);
}
