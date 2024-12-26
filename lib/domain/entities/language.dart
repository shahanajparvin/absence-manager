

import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:flutter/material.dart';


enum Language {
  german('de', 'German'), english('en', 'English');

  final String languageCode;
  final String languageName;

  const Language(this.languageCode, this.languageName);

  static Language getLanguageByName(String languageName) {
    switch (languageName) {
      case 'German': return Language.german;
      case 'English': return Language.english;
      default: return Language.german;
    }
  }

  static Language getLanguageByCode(String code) {
    switch (code) {
      case 'de': return Language.german;
      case 'en': return Language.english;
      default: return Language.german;
    }
  }

  static String getLocalizedLanguageName(BuildContext context, String code) {
    switch (code) {
      case 'de': return context.text.german;
      case 'en': return context.text.english;
      default: return context.text.german;
    }
  }

  List<String> getLanguageNames() {
    return <String>[Language.german.languageName, Language.english.languageName];
  }

  Locale get locale {
    return Locale(languageCode, _getCountryCodeForLocale());
  }


  String _getCountryCodeForLocale() {
    switch (languageCode) {
      case 'de': return 'DE';
      case 'en': return 'US';
      default : return 'DE';
    }
  }
}