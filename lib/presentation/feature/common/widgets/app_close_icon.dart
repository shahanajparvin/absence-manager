import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';


class CloseIconWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const CloseIconWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColor.splashColor,
        borderRadius: BorderRadius.circular(5),
        onTap: onPressed,
        child: Padding(
         padding: EdgeInsets.all(AppHeight.s5),
          child: Icon(
            Icons.close, // Close icon inside the circle
            color: AppColor.darkGreyColor, // Icon color
            size: AppWidth.s20, // Icon size to fit within 30x30 container
          ),
        ),
      ),
    );
  }
}
