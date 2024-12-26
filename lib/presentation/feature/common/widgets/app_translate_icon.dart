import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_modal_controller.dart';
import 'package:absence_manager/core/utils/app_settings.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/presentation/feature/lanuage/ui/change_language_view.dart';
import 'package:flutter/material.dart';

class TranslateIcon extends StatelessWidget {
  final ModalController modalController;
  final Color? color;
  final VoidCallback? onChange;
  final AppSettings appSettings;
  final ChangeLanguageView changeLanguageView;
  final BuildContext modalContext;

  const TranslateIcon(
      {super.key,
      required this.modalController,
      this.color,
      this.onChange,
      required this.appSettings,
      required this.changeLanguageView,
      required this.modalContext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppWidth.s10),
      child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(
              Icons.translate,
              color: AppColor.appBarColor,
            ),
            onPressed: () {
              modalController.showModal(modalContext, changeLanguageView);
            },
          )),
    );
  }
}
