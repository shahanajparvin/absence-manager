import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageEvent', () {
    late Language englishLanguage;

    setUp(() {
      englishLanguage = Language.german;
    });

    test('ChangeLanguage event should store selectedLanguage correctly', () {
      final ChangeLanguage changeLanguageEvent = ChangeLanguage(selectedLanguage: englishLanguage);

      expect(changeLanguageEvent.selectedLanguage, englishLanguage);
    });
  });
}
