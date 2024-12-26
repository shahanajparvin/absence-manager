

import 'package:absence_manager/domain/entities/language.dart';

class LanguageState {
  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;

  final Language selectedLanguage;

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}



