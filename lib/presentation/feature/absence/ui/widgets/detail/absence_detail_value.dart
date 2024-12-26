import 'package:absence_manager/core/utils/app_color.dart';
import 'package:flutter/material.dart';


class AbsenceDetailValue extends StatelessWidget {
  final String value;
  final Color? color;

  const AbsenceDetailValue({super.key, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w500, color: color ?? AppColor.themeBlackColor),
    );
  }
}
