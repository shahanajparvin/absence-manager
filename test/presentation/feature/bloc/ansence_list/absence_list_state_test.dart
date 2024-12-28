import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AbsenceListState', () {
    test('AbsenceInitial should have empty props', () {
      final AbsenceInitial state = AbsenceInitial();
      expect(state.props, <Object?>[]);
    });

    test('AbsenceLoadingState should have empty props', () {
      final AbsenceLoadingState state = AbsenceLoadingState();
      expect(state.props, <Object?>[]);
    });

    test('AbsenceSuccessState should have correct props', () {
      final List<AbsenceListModel> absences = <AbsenceListModel>[];
      final AbsenceSuccessState state = AbsenceSuccessState(absences, hasMorePages: true);

      expect(state.props, <Object?>[absences, true]);
    });

    test('AbsenceErrorState should have correct props', () {
      const String errorMessage = 'Some error';
      final AbsenceErrorState state = AbsenceErrorState(errorMessage);

      expect(state.props, <Object?>[errorMessage]);
    });
  });
}
