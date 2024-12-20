

abstract class AbsenceListEvent {}

class GetAbsencesWithMembersEvent extends AbsenceListEvent {}

class FetchPaginatedAbsenceEvent extends AbsenceListEvent {
  final int itemsPerPage;
  FetchPaginatedAbsenceEvent(this.itemsPerPage);
}

class FilterAbsencesEvent extends AbsenceListEvent {
  final String? type;
  final String? startDate;
  final String? endDate;

  FilterAbsencesEvent( {this.type, this.startDate, this.endDate});
}

class ResetFiltersEvent extends AbsenceListEvent {
  ResetFiltersEvent();
}
