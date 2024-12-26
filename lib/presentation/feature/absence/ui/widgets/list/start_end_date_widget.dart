

import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StartEndDateWidget extends StatelessWidget {
  final String startedOn;
  final String endOn;

  const StartEndDateWidget({super.key, required this.startedOn, required this.endOn});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppDateClassWidget(date: startedOn,label: context.text.started_on,),
        Gap(AppHeight.s6),
        AppDateClassWidget(date: endOn,label: context.text.ended_on,),
      ],
    );
  }
}


class AppDateClassWidget extends StatelessWidget {

  final String label;
  final String date;

  const AppDateClassWidget({super.key, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Text('$label:',style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(
              fontSize: AppTextSize.s14,
              color: AppColor.themeDeepBlackColor)),
          Gap(AppWidth.s5),
          Text(
          date,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColor.dateColor),
          )
        ]

    );
  }
}


