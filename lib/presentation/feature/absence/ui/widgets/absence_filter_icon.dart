import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class FilterIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.themeColor,
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(AppHeight.s10),
          child: AppIcon(
            assetName: AppImage.icFilter,
            height: AppHeight.s14,
            width: AppWidth.s14,
            color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
