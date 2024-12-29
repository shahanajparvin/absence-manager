import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('FetchAbsenceDetailsEvent', () {
    test('should create event with correct absence ID', () {

      const int expectedId = 123;


      final FetchAbsenceDetailsEvent event = FetchAbsenceDetailsEvent(expectedId);


      expect(event.absenceId, equals(expectedId));
    });

    test('should extend AbsenceDetailEvent', () {

      final FetchAbsenceDetailsEvent event = FetchAbsenceDetailsEvent(1);


      expect(event, isA<AbsenceDetailEvent>());
    });

    test('events with same ID should be equal', () {

      final FetchAbsenceDetailsEvent event1 = FetchAbsenceDetailsEvent(1);
      final FetchAbsenceDetailsEvent event2 = FetchAbsenceDetailsEvent(1);


      expect(event1.absenceId, equals(event2.absenceId));
    });

    test('events with different IDs should not be equal', () {

      final FetchAbsenceDetailsEvent event1 = FetchAbsenceDetailsEvent(1);
      final FetchAbsenceDetailsEvent event2 = FetchAbsenceDetailsEvent(2);


      expect(event1.absenceId, isNot(equals(event2.absenceId)));
    });
  });
}