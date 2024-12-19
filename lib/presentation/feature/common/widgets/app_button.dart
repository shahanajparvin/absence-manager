import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constants.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String label;
  final Color? backGroundColor;
  final Color? labelColor;

  final void Function()? onPressed;

  const AppButton({
    super.key,
    required this.label,
    this.backGroundColor,
    this.labelColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColor.lightGreyColor, width: AppWidth.s1),
            borderRadius: BorderRadius.circular(AppConst.buttonRadius),
          )
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: labelColor ?? AppColor.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: AppTextSize.s12),
        ),

    );
  }
}
