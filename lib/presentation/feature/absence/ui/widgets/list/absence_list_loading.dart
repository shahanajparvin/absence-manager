import 'package:absence_manager/core/utils/app_color.dart';
import 'package:flutter/cupertino.dart';

class AbsenceListLoadingWidget extends StatelessWidget {
  final double height;

  const AbsenceListLoadingWidget({super.key, this.height = 60.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColor.lightGreyColor,
      child: const Center(
        child: CupertinoActivityIndicator(
          color: AppColor.themeColor,
        ),
      ),
    );
  }
}
