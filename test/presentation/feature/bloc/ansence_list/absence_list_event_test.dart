import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:test/test.dart';


void main() {
  group('AbsenceListEvent', () {
    test('GetAbsencesWithMembersEvent should be instantiated correctly', () {
      final GetAbsencesWithMembersEvent event = GetAbsencesWithMembersEvent();

      expect(event, isA<GetAbsencesWithMembersEvent>());
    });

    test('FetchPaginatedAbsenceEvent should be instantiated with correct itemsPerPage', () {
      const int itemsPerPage = 20;
      final FetchPaginatedAbsenceEvent event = FetchPaginatedAbsenceEvent(itemsPerPage);

      expect(event, isA<FetchPaginatedAbsenceEvent>());
      expect(event.itemsPerPage, equals(itemsPerPage));
    });

    test('FilterAbsencesEvent should be instantiated with null values for optional params', () {
      final FilterAbsencesEvent event = FilterAbsencesEvent();

      expect(event, isA<FilterAbsencesEvent>());
      expect(event.type, isNull);
      expect(event.startDate, isNull);
      expect(event.endDate, isNull);
    });

    test('FilterAbsencesEvent should be instantiated with provided parameters', () {
      final FilterAbsencesEvent event = FilterAbsencesEvent(type: 'Sick', startDate: '2024-01-01', endDate: '2024-01-31');

      expect(event, isA<FilterAbsencesEvent>());
      expect(event.type, equals('Sick'));
      expect(event.startDate, equals('2024-01-01'));
      expect(event.endDate, equals('2024-01-31'));
    });

    test('SearchAbsencesEvent should be instantiated with searchText', () {
      const String searchText = 'sick leave';
      final SearchAbsencesEvent event = SearchAbsencesEvent(searchText: searchText);

      expect(event, isA<SearchAbsencesEvent>());
      expect(event.searchText, equals(searchText));
    });

    test('ResetFiltersEvent should be instantiated correctly', () {
      final ResetFiltersEvent event = ResetFiltersEvent();

      expect(event, isA<ResetFiltersEvent>());
    });
  });
}
