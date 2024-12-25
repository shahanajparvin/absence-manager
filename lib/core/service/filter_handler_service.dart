import 'package:absence_manager/core/service/app_dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';


@Injectable()
class FilterHandler {
  final AppDialogService _appDialogService;

  FilterHandler(this._appDialogService);

  void showFilterDialog({
    required BuildContext context,
    required FilterDataBloc dataBloc,
    required Widget filterWidget,
    required Widget filterHeaderWidget,
    required Widget filterBottomWidget,
  }) {
    dataBloc.isApplyEnabled.value = false;

    _showDialog(
      context: context,
      filterWidget: filterWidget,
      filterHeaderWidget: filterHeaderWidget,
      bottomWidget: filterBottomWidget,
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

}

abstract class FilterDataBloc {
  bool get hasFilters;
  void resetFilters();
  final ValueNotifier<bool> isApplyEnabled = ValueNotifier<bool>(false);
}



