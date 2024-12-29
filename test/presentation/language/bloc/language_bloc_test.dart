import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_bloc.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_event.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageBloc', () {
    late Language initialLanguage;
    late Language newLanguage;
    late LanguageBloc languageBloc;

    setUp(() {
      // Define initial and new languages for testing
      initialLanguage =  Language.german;
      newLanguage =  Language.english;
      languageBloc = LanguageBloc(initialLanguage);
    });

    tearDown(() {
      languageBloc.close();
    });

    test('initial state should be LanguageState with initialLanguage', () {
      expect(
        languageBloc.state,
        LanguageState(selectedLanguage: initialLanguage),
      );
    });

    blocTest<LanguageBloc, LanguageState>(
      'emits [LanguageState] with the updated selectedLanguage when ChangeLanguage is added',
      build: () => languageBloc,
      act: (LanguageBloc bloc) => bloc.add(ChangeLanguage(selectedLanguage: newLanguage)),
      expect: () => <LanguageState>[
        LanguageState(selectedLanguage: newLanguage),
      ],
    );
  });
}
