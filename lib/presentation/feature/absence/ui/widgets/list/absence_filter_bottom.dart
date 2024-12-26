import 'package:absence_manager/core/service/filter_handler_service.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_event.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/filter/absence_filter_data_bloc_impl.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';



class AbsenceFilterBottomWidget extends StatelessWidget {
  final AbsenceFilterDataBloc absenceFilterDataBloc;


  const AbsenceFilterBottomWidget({
    required this.absenceFilterDataBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: absenceFilterDataBloc.isApplyEnabled,
      builder: (BuildContext context, bool isApplyEnabled, _) {
        return AbsenceFilterBottomChild(
          onApply: _canApply(absenceFilterDataBloc)
              ? () {
            Navigator.of(context).pop();
             _applyFilters(
              context: context,
                startDate: absenceFilterDataBloc.startDate,
                endDate: absenceFilterDataBloc.endDate,
                type: absenceFilterDataBloc.sickType);
          }
              : null,
          onReset: _canReset(absenceFilterDataBloc)
              ? () {
            Navigator.of(context).pop();
            absenceFilterDataBloc.resetFilters();
            _resetFilters(context);
          }
              : null,
        );
      },
    );
  }
  bool _canApply(FilterDataBloc dataBloc) =>
      dataBloc.isApplyEnabled.value || dataBloc.hasFilters;

  bool _canReset(FilterDataBloc dataBloc) =>
      dataBloc.isApplyEnabled.value || dataBloc.hasFilters;

  void _applyFilters({
    String? type,
    String? startDate,
    String? endDate,
    required BuildContext context
  }) {
    BlocProvider.of<AbsenceListBloc>(context).add(FilterAbsencesEvent(
        type: type, startDate: startDate, endDate: endDate));
  }

  void _resetFilters(BuildContext context) {
    BlocProvider.of<AbsenceListBloc>(context).add(ResetFiltersEvent());
  }
}



class AbsenceFilterBottomChild extends StatelessWidget {
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  const AbsenceFilterBottomChild({
    super.key,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: AppHeight.s20),
      height: AppConst.filterBottomHeight+AppHeight.s20 ,
      child: Row(
        children: [
          AppButton(
              labelColor: onApply==null?AppColor.themeDeepBlackColor:null,
              onPressed: onApply, // Call the onApply callback
              backGroundColor: AppColor.activeColor,
              label: context.text.apply,

            ),
          Gap(AppHeight.s15),
          AppButton(
              labelColor: AppColor.themeDeepBlackColor,
              onPressed: onReset, // Call the onReset callback
              backGroundColor: AppColor.whiteColor,
              label:  context.text.reset,
            ),
        ],
      ),
    );
  }
}
