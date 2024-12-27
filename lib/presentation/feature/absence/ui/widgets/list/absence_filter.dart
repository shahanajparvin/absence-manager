import 'package:absence_manager/core/service/ansence_type_service.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_date_widget.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AbsenceFilter extends StatefulWidget {
  final AbsenceFilterDataBloc dataBloc;

  const AbsenceFilter({required this.dataBloc});

  @override
  _AbsenceFilterState createState() => _AbsenceFilterState();
}

class _AbsenceFilterState extends State<AbsenceFilter> {
  DateTimeRange? selectedDateRange;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  late AbsenceTypeService _absenceTypeService;

  @override
  void initState() {
    super.initState();
    if (widget.dataBloc.startDate != null) {
      _startDateController.text = widget.dataBloc.startDate!;
    }
    if (widget.dataBloc.endDate != null) {
      _endDateController.text = widget.dataBloc.endDate!;
    }
    _absenceTypeService = AbsenceTypeService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppDropDown(
          initialValue: widget.dataBloc.sickType!=null? _absenceTypeService.convertValueToReadableName(widget.dataBloc.sickType!):null,
          items: _absenceTypeService.getReadableAbsenceTypeList(),
          hintText: context.text.select_type,
          label: context.text.type_of_absence,
          onSelectCallBack: (String? type) {
            final AbsenceTypeEnum? selectedEnum = _absenceTypeService
                .parseReadableAbsenceType(type.toString());
            if (selectedEnum != null) {
              widget.dataBloc.updateSickType(selectedEnum.name);
            }
          }
        ),
        Gap(AppConst.betweenPadding),
        AppDatePickerField(
          dateController: _startDateController,
          label: context.text.start_date,
          onSelect: (String selectDate) {
            widget.dataBloc.updateStartDate(selectDate);
          },
        ),
        Gap(AppConst.betweenPadding),
        AppDatePickerField(
          dateController: _endDateController,
          label: context.text.end_date,
          onSelect: (String selectDate) {
            widget.dataBloc.updateEndDate(selectDate);
          },
        )
      ],
    );
  }
}

