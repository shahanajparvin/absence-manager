import 'package:absence_manager/core/utils/app_context.dart';
import 'package:absence_manager/core/utils/core_utils.dart';


class AbsenceStatusService {
  static final Map<String, String Function()> _statusMappings = {
    'confirmed': () => AppContext.context.text.confirm,
    'rejected': () => AppContext.context.text.reject,
    'pending': () => AppContext.context.text.pending,
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




