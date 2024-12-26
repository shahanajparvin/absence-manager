import 'package:absence_manager/core/mixin/input_decoration_mixin.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AppDatePickerField extends StatelessWidget with InputDecorationMixin {
  final String label;
  final TextEditingController dateController;
  final Function(String) onSelect;

  const AppDatePickerField(
      {super.key, required this.dateController, required this.label, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textFieldLabel(context: context, label: label),
        Gap(AppConst.labelGap),
        TextFormField(
          controller: dateController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: true,
            decoration: customInputDecoration(
              context: context,
              hintText: context.text.select_date,
              suffixIcon: Padding(
                  padding: EdgeInsets.only(
                      top: AppHeight.s10,
                      bottom: AppHeight.s10,
                      left: AppHeight.s10,
                      right: AppHeight.s10),
                  child: AppIcon(
                      assetName: AppImage.icCalender,
                      height: AppWidth.s18,
                      width: AppWidth.s18,
                      color: AppColor.greyColor)),
            ),

           onTap: (){
              _selectDate(context);
           },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dateController.text = dateFormat.format(pickedDate);
    }
  }
}
