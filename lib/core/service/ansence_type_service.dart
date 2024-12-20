import 'package:absence_manager/core/utils/app_context.dart';
import 'package:absence_manager/core/utils/core_utils.dart';

class AbsenceTypeService {
  static final Map<String, String Function()> _statusMappings = {
    'sickness': () => AppContext.context.text.sickness,
    'vacation': () => AppContext.context.text.vacation,
  };

  static String getReadableStatusName(String inputValue) {
    final String key = inputValue.toLowerCase(); // Normalize the input
    if (_statusMappings.containsKey(key)) {
      return _statusMappings[key]!();
    } else {
      return inputValue;
    }
  }
}