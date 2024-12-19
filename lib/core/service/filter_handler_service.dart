import 'package:absence_manager/core/service/app_dialog_service.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/absence_filter_bottom.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';


@Injectable()
class FilterHandler {
  final AppDialogService _appDialogService;

  FilterHandler(this._appDialogService);

  void showFilterDialog({
    required BuildContext context,
    required FilterDataBloc dataBloc,
    required VoidCallback onApply,
    required VoidCallback onReset,
    required Widget filterWidget,
    required Widget filterHeaderWidget,
  }) {
    dataBloc.isApplyEnabled.value = false;

    _showDialog(
      context: context,
      filterWidget: filterWidget,
      filterHeaderWidget: filterHeaderWidget,
      bottomWidget: _buildFilterBottomWidget(
        context: context,
        dataBloc: dataBloc,
        onApply: onApply,
        onReset: onReset,
      ),
    );
  }

  void _showDialog({
    required BuildContext context,
    required Widget filterWidget,
    required Widget filterHeaderWidget,
    required Widget bottomWidget,
  }) {
    _appDialogService.showBlurredChildDialog(
      headerWidget: filterHeaderWidget,
      context: context,
      isScroll: true,
      child: filterWidget,
      bottomChild: bottomWidget,
    );
  }

  Widget _buildFilterBottomWidget({
    required BuildContext context,
    required FilterDataBloc dataBloc,
    required VoidCallback onApply,
    required VoidCallback onReset,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: dataBloc.isApplyEnabled,
      builder: (BuildContext context, bool isApplyEnabled, _) {
        return AbsenceFilterBottom(
          onApply: canApply(dataBloc)
              ? () {
            Navigator.of(context).pop();
            onApply();
          }
              : null,
          onReset: canReset(dataBloc)
              ? () {
            Navigator.of(context).pop();
            dataBloc.resetFilters();
            onReset();
          }
              : null,
        );
      },
    );
  }

  bool canApply(FilterDataBloc dataBloc) =>
      dataBloc.isApplyEnabled.value || dataBloc.hasFilters;

  bool canReset(FilterDataBloc dataBloc) =>
      dataBloc.isApplyEnabled.value || dataBloc.hasFilters;
}

abstract class FilterDataBloc {
  bool get hasFilters;
  void resetFilters();
  final ValueNotifier<bool> isApplyEnabled = ValueNotifier<bool>(false);
}



