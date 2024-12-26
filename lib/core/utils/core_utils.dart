import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


extension LocalizationExtension on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}


class AppUtils {
  /// Adds a delay for the given duration.
  static Future<void> delay(Duration duration) async {
    await Future<void>.delayed(duration);
  }
}

