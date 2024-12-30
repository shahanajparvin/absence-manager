import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AbsenceFilterDataBloc extends FilterDataBloc {
  String? _sickType;
  String? _startDate;
  String? _endDate;

  String? get sickType => _sickType;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  void updateSickType(String type) {
    _sickType = type;
    isApplyEnabled.value = hasFilters;
  }

  void updateStartDate(String newStartDate) {
    _startDate = newStartDate;
    isApplyEnabled.value = hasFilters;
  }

  void updateEndDate(String newEndDate) {
    _endDate = newEndDate;
    isApplyEnabled.value = hasFilters;
  }

  @override
  void resetFilters() {
    _sickType = null;
    _startDate = null;
    _endDate = null;
  }

  @override
  bool get hasFilters {
    return _sickType!=null || _startDate!=null || _endDate!=null;
  }
}
