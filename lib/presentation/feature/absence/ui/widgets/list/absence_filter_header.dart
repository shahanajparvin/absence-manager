import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AbsenceFilterHeader extends StatelessWidget {
  const AbsenceFilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      AppIcon(
          width: AppWidth.s18,
          height: AppHeight.s18,
          color: AppColor.tealColor,
          assetName: AppImage.icFilterHeader),
      Gap(AppWidth.s10),
      const Text('Filter'),
    ]);
  }
}
