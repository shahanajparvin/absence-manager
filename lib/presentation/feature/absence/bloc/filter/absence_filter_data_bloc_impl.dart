import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AbsenceFilterDataBloc extends FilterDataBloc {
  String _sickType = '';
  String _startDate = '';

  String get sickType => _sickType;

  String get startDate => _startDate;

  void updateSickType(String type) {
    _sickType = type;
    isApplyEnabled.value = hasFilters;
  }

  void updateStartDate(String newStartDate) {
    _startDate = newStartDate;
    isApplyEnabled.value = hasFilters;
  }

  @override
  void resetFilters() {
    _sickType = '';
    _startDate = '';
  }

  @override
  bool get hasFilters {
    return _sickType.isNotEmpty || _startDate.isNotEmpty;
  }
}
