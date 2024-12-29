import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_state.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'absence_detail_state_test.mocks.dart';



@GenerateMocks(<Type>[AbsenceDetailModel])
void main() {
  group('AbsenceDetailState', () {
    group('AbsenceDetailInitial', () {
      test('props should be empty', () {
        final AbsenceDetailInitial state = AbsenceDetailInitial();
        expect(state.props, equals(<Object>[]));
      });

      test('two instances should be equal', () {
        final AbsenceDetailInitial state1 = AbsenceDetailInitial();
        final AbsenceDetailInitial state2 = AbsenceDetailInitial();
        expect(state1, equals(state2));
      });
    });

    group('AbsenceDetailLoadingState', () {
      test('props should be empty', () {
        final AbsenceDetailLoadingState state = AbsenceDetailLoadingState();
        expect(state.props, equals(<Object>[]));
      });

      test('two instances should be equal', () {
        final AbsenceDetailLoadingState state1 = AbsenceDetailLoadingState();
        final AbsenceDetailLoadingState state2 = AbsenceDetailLoadingState();
        expect(state1, equals(state2));
      });
    });

    group('AbsenceDetailSuccessState', () {
      late MockAbsenceDetailModel mockModel;

      setUp(() {
        mockModel = MockAbsenceDetailModel();
      });

      test('props should contain absenceDetailView', () {
        final AbsenceDetailSuccessState state = AbsenceDetailSuccessState(mockModel);
        expect(state.props, equals(<Object>[mockModel]));
      });

      test('two instances with same model should be equal', () {
        final AbsenceDetailSuccessState state1 = AbsenceDetailSuccessState(mockModel);
        final AbsenceDetailSuccessState state2 = AbsenceDetailSuccessState(mockModel);
        expect(state1, equals(state2));
      });

      test('two instances with different models should not be equal', () {
        final AbsenceDetailSuccessState state1 = AbsenceDetailSuccessState(mockModel);
        final AbsenceDetailSuccessState state2 = AbsenceDetailSuccessState(MockAbsenceDetailModel());
        expect(state1, isNot(equals(state2)));
      });

      test('should store absenceDetailView correctly', () {
        final AbsenceDetailSuccessState state = AbsenceDetailSuccessState(mockModel);
        expect(state.absenceDetailView, equals(mockModel));
      });
    });

    group('AbsenceDetailErrorState', () {
      test('props should contain errorMessage', () {
        const String errorMessage = 'Error occurred';
        final AbsenceDetailErrorState state = AbsenceDetailErrorState(errorMessage);
        expect(state.props, equals(<String>[errorMessage]));
      });

      test('two instances with different error messages should not be equal', () {
        final AbsenceDetailErrorState state1 = AbsenceDetailErrorState('Error 1');
        final AbsenceDetailErrorState state2 = AbsenceDetailErrorState('Error 2');
        expect(state1, isNot(equals(state2)));
      });

      test('should store errorMessage correctly', () {
        const String errorMessage = 'Error occurred';
        final AbsenceDetailErrorState state = AbsenceDetailErrorState(errorMessage);
        expect(state.errorMessage, equals(errorMessage));
      });
    });
  });
}