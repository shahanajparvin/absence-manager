import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageState', () {
    late Language germanLanguage;
    late Language englishLanguage;

    setUp(() {
      germanLanguage = Language.german;
      englishLanguage = Language.english;
    });

    test('supports equality comparison using Equatable', () {
      final LanguageState state1 = LanguageState(selectedLanguage: germanLanguage);
      final LanguageState state2 = LanguageState(selectedLanguage: germanLanguage);
      final LanguageState state3 = LanguageState(selectedLanguage: englishLanguage);

      // state1 and state2 should be equal because they have the same selectedLanguage
      expect(state1, state2);

      // state1 and state3 should not be equal because they have different selectedLanguages
      expect(state1, isNot(state3));
    });

    test('copyWith returns a new instance with updated selectedLanguage', () {
      final LanguageState initialState = LanguageState(selectedLanguage: germanLanguage);

      final LanguageState newState = initialState.copyWith(selectedLanguage: englishLanguage);

      expect(initialState.selectedLanguage, germanLanguage);
      expect(newState.selectedLanguage, englishLanguage);
      expect(initialState, isNot(newState));
    });

    test('copyWith does not change the selectedLanguage if none is provided', () {
      final LanguageState initialState = LanguageState(selectedLanguage: germanLanguage);

      final LanguageState newState = initialState.copyWith();

      expect(initialState.selectedLanguage, newState.selectedLanguage);
    });
  });
}
