// absence_event.dart

// absence_event.dart

abstract class AbsenceEvent {}

class GetAbsencesWithMembersEvent extends AbsenceEvent {}

class LoadPageEvent extends AbsenceEvent {
  final int itemsPerPage;

  LoadPageEvent(this.itemsPerPage);
}

