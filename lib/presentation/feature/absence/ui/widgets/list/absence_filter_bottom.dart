import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class AbsenceFilterBottom extends StatelessWidget {
  final VoidCallback? onApply;
  final VoidCallback? onReset;

  const AbsenceFilterBottom({
    super.key,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: AppHeight.s20),
      height: AppConst.filterBottomHeight+AppHeight.s20 ,
      child: Row(
        children: [
          AppButton(
              labelColor: onApply==null?AppColor.themeDeepBlackColor:null,
              onPressed: onApply, // Call the onApply callback
              backGroundColor: AppColor.activeColor,
              label: 'Apply',

            ),
          Gap(AppHeight.s15),
          AppButton(
              labelColor: AppColor.themeDeepBlackColor,
              onPressed: onReset, // Call the onReset callback
              backGroundColor: AppColor.whiteColor,
              label: 'Reset',
            ),
        ],
      ),
    );
  }
}
