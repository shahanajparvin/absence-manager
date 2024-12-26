import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AbsenceDetailTitle extends StatelessWidget {

  final String iconAsset;
  final String title;
  final Color? titleColor;

  const AbsenceDetailTitle({super.key, required this.iconAsset, required this.title,  this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: AppHeight.s2),
            child: AppIcon(
              color: AppColor.themeColor,
                width: AppWidth.s16,
                height: AppWidth.s16,
                assetName: iconAsset),
          ),

      Gap(AppWidth.s6),

      Flexible(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(
              color: titleColor ?? AppColor.textColorDark, fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }
}
