
import 'package:absence_manager/core/service/absence_status_service.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';

class AbsenceStatusWidget extends StatelessWidget {
  final String status;

  const AbsenceStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {

    final _StatusColors color = _getColorsForStatus(status);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.backgroundColor,
      ),
      child: Text(
        AbsenceStatusService.getReadableStatusName(status),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontSize: AppTextSize.s12,color: color.textColor,fontWeight: FontWeight.w500),
      ),
    );
  }

  _StatusColors _getColorsForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return _StatusColors(
          textColor: Colors.green,
          backgroundColor: Colors.green.withOpacity(0.05),
        );
      case 'rejected':
        return _StatusColors(
          textColor: Colors.red,
          backgroundColor:Colors.red.withOpacity(0.05),
        );
      case 'pending':
        return _StatusColors(
          textColor: Colors.orange,
          backgroundColor: Colors.orange.withOpacity(0.05),
        );
      default:
        return _StatusColors(
          textColor: AppColor.themeColor,
          backgroundColor: AppColor.themeColor.withOpacity(0.1),
        );
    }
  }
}

class _StatusColors {
  final Color textColor;
  final Color backgroundColor;

  _StatusColors({required this.textColor, required this.backgroundColor});
}

