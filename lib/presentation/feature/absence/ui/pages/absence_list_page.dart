import 'package:absence_manager/core/di/injector.dart';
import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_modal_controller.dart';
import 'package:absence_manager/core/utils/app_settings.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/main_common.dart';
import 'package:absence_manager/presentation/feature/absence/bloc/absence_list/absence_list_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/ui/widgets/list/absence_list.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_translate_icon.dart';
import 'package:absence_manager/presentation/feature/lanuage/ui/change_language_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({super.key});

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {
  final ModalController modalController = injector();

  final ChangeLanguageView changeLanguageView = ChangeLanguageView(
    appSettings: appSettings,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
            padding: EdgeInsets.only(left: AppWidth.s10),
            child: Text(
              context.text.absence_manager,
              style: context.textTheme.displayMedium,
            )),
        actions: <Widget>[
          TranslateIcon(
            modalController: modalController,
            appSettings: appSettings,
            changeLanguageView: changeLanguageView,
            modalContext: context,
          ),
        ],
      ),
      body: BlocProvider<AbsenceListBloc>(
        create: (_) => injector(),
        child: AbsenceListWidget(),
      ),
    );
  }
}
