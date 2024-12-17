

abstract class AbsenceListEvent {}

class GetAbsencesWithMembersEvent extends AbsenceListEvent {}

class FetchPaginatedAbsenceEvent extends AbsenceListEvent {
  final int itemsPerPage;

  FetchPaginatedAbsenceEvent(this.itemsPerPage);
}

class FetchAbsenceDetailsEvent extends AbsenceListEvent {
  final int absenceId;
  FetchAbsenceDetailsEvent(this.absenceId);
}