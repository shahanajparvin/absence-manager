// absence_event.dart

// absence_event.dart

abstract class AbsenceEvent {}

class GetAbsencesWithMembersEvent extends AbsenceEvent {}

class FetchPaginatedAbsenceEvent extends AbsenceEvent {
  final int itemsPerPage;

  FetchPaginatedAbsenceEvent(this.itemsPerPage);
}

