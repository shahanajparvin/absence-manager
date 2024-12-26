

import 'package:absence_manager/domain/entities/language.dart';

abstract class LanguageEvent{
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  const ChangeLanguage({required this.selectedLanguage});

  final Language selectedLanguage;

  @override
  List<Object> get props => [selectedLanguage];
}


class ChangeLanguageWithBackend extends LanguageEvent {
  final Language selectedLanguage;
  final bool isLogin;

  const ChangeLanguageWithBackend({required this.selectedLanguage, this.isLogin = false});

}
