
import 'package:absence_manager/domain/entities/language.dart';
import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;

  final Language selectedLanguage;

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => <Object?>[selectedLanguage];
}




