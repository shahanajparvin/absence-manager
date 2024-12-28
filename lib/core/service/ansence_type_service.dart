import 'package:absence_manager/core/utils/app_context.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:flutter/material.dart';


/*class AbsenceTypeService {

  AbsenceTypeService();


  List<String> getReadableAbsenceTypeList() {
    return AbsenceTypeEnum.values.map((AbsenceTypeEnum e) => e.readableValue).toList();
  }


  AbsenceTypeEnum? parseReadableAbsenceType(String readableValue) {
    final Map<String, AbsenceTypeEnum> absenceTypeMap = <String, AbsenceTypeEnum>{
      AppContext.context.text.all: AbsenceTypeEnum.all,
      AppContext.context.text.sickness: AbsenceTypeEnum.sickness,
      AppContext.context.text.vacation: AbsenceTypeEnum.vacation,
    };

    return absenceTypeMap[readableValue];
  }


  String getReadableAbsenceType(AbsenceTypeEnum method) {
    return method.readableValue;
  }
}


extension AbsenceTypeExtension on AbsenceTypeEnum {
  String get readableValue {
    switch (this) {
      case AbsenceTypeEnum.all:
        return AppContext.context.text.all;
      case AbsenceTypeEnum.sickness:
        return AppContext.context.text.sickness; 
      case AbsenceTypeEnum.vacation:
        return AppContext.context.text.vacation; 
      default:
        return '';
    }
  }
}


enum AbsenceTypeEnum {
  all,
  sickness,
  vacation,
}*/






class AbsenceTypeService {
  final BuildContext context;

  AbsenceTypeService(this.context);

  List<String> getReadableAbsenceTypeList() {
    return AbsenceTypeEnum.values.map((AbsenceTypeEnum e) => getReadableAbsenceType(e)).toList();
  }

  AbsenceTypeEnum? parseReadableAbsenceType(String readableValue) {
    final String all = AppContext.context.text.all;
    final String sickness = AppContext.context.text.sickness;
    final String vacation = AppContext.context.text.vacation;


    if (readableValue == all) {
      return AbsenceTypeEnum.all;
    } else if (readableValue == sickness) {
      return AbsenceTypeEnum.sickness;
    } else if (readableValue == vacation) {
      return AbsenceTypeEnum.vacation;
    } else {
      return null; // Return null if no match is found
    }
  }

  AbsenceTypeEnum? parseValueAbsenceType(String readableValue) {
    switch (readableValue) {
      case 'all':
        return AbsenceTypeEnum.all;
      case 'sickness':
        return AbsenceTypeEnum.sickness;
      case 'vacation':
        return AbsenceTypeEnum.vacation;
      default:
        return null; // Return null if no match is found
    }
  }

  String convertValueToReadableName(String readableValue) {
    final AbsenceTypeEnum? absenceTypeEnum = parseValueAbsenceType(readableValue);
      final String readableName = getReadableAbsenceType(absenceTypeEnum!);
      return readableName;
  }

  String getReadableAbsenceType(AbsenceTypeEnum absenceTypeEnum) {
    switch (absenceTypeEnum) {
      case AbsenceTypeEnum.all:
        return AppContext.context.text.all;
      case AbsenceTypeEnum.sickness:
        return AppContext.context.text.sickness;
      case AbsenceTypeEnum.vacation:
        return AppContext.context.text.vacation; // Use context for localization
      default:
        return '';
    }
  }
}

enum AbsenceTypeEnum {
  all,
  sickness,
  vacation,
}






/*class AbsenceTypeService {

  static final Map<String, String Function()> _statusMappings = <String, String Function()>{
    'all': () => AppContext.context.text.all,
    'sickness': () => AppContext.context.text.sickness,
    'vacation': () => AppContext.context.text.vacation,
  };

  static String getReadableStatusName(String inputValue) {
    final String key = inputValue.toLowerCase(); // Normalize the input
    if (_statusMappings.containsKey(key)) {
      return _statusMappings[key]!();
    } else {
      return inputValue; // Default to the input value if no match is found
    }
  }

  static List<String> getLocalizedAbsenceTypes() {
    return _statusMappings.keys.map((String key) => getReadableStatusName(key)).toList();
  }

  String? getRawValueFromLocalized(String localizedValue) {
    return absenceTypeLocalization.entries
        .firstWhere(
            (entry) => entry.value() == localizedValue,
        orElse: () => const MapEntry('', () => ''))
        .key;
  }

}*/
