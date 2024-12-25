import 'package:absence_manager/core/utils/app_constant.dart';
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
  String? selectedType;
  final List<String> absenceTypes = ['All', 'Vacation', 'Sickness',];
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.dataBloc.startDate!=null){
      _startDateController.text = widget.dataBloc.startDate!;
    }
    if(widget.dataBloc.endDate!=null){
      _endDateController.text = widget.dataBloc.endDate!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize : MainAxisSize.min,
      children: [
        AppDropDown(
          initialValue: widget.dataBloc.sickType,
          items: absenceTypes,
          hintText: 'Please Select type ',
          label: 'Type', onSelectCallBack: (String? type) {
            selectedType = type;
            if(type!=null) {
              widget.dataBloc.updateSickType(type);
            }
          },
        ),
        Gap(AppConst.betweenPadding),
        AppDatePickerField(
          dateController: _startDateController,
          label: 'Start Date',
          onSelect: (String selectDate){
            widget.dataBloc.updateStartDate(selectDate);
          }
        ),
        Gap(AppConst.betweenPadding),
        AppDatePickerField(
            dateController: _endDateController,
            label: 'End Date',
            onSelect: (String selectDate){
              widget.dataBloc.updateEndDate(selectDate);
            }
        )
      ],
    );
  }
}
