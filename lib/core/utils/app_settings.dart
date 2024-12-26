import 'package:absence_manager/core/utils/app_key.dart';
import 'package:absence_manager/domain/entities/language.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class AppSettings {
  late SharedPreferences _prefs;


  AppSettings._(this._prefs);


  static Future<AppSettings> create() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return AppSettings._(prefs);
  }

  Future<void> setSelectedLanguage(Language language) async {
    await _prefs.setString(AppKey.keyCurrentLanguage, language.languageCode);
  }

  Language getSelectedLanguage() {
    final String? code = _prefs.getString(AppKey.keyCurrentLanguage);
    if (code != null) {
      return Language.getLanguageByCode(code);
    } else {
      return Language.getLanguageByCode(Language.german.languageCode);
    }
  }
}
