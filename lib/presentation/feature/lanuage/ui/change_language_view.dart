import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_settings.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/main_common.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_button.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_close_icon.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_bloc.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_event.dart';
import 'package:absence_manager/presentation/feature/lanuage/ui/language_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


class ChangeLanguageView extends StatefulWidget {

  final AppSettings appSettings;

  const ChangeLanguageView(
      {super.key,
      required this.appSettings});

  @override
  State<StatefulWidget> createState() => ChangeLanguageViewState();
}

class ChangeLanguageViewState extends State<ChangeLanguageView> {
  Language selectedLanguage = Language.german;
  late final Function(Language) onLangChange;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.appSettings.getSelectedLanguage();
    onLangChange = (Language changedLanguage) {
      setState(() {
        selectedLanguage = changedLanguage;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppWidth.s15, vertical: AppHeight.s20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppWidth.s5),
            child: Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              crossAxisAlignment : CrossAxisAlignment.start,
              children: <Widget>[
                _getTitle(),
                CloseIconWidget(onPressed:(){
                  context.pop();
                })
              ],
            ),
          ),
          Gap(AppHeight.s15),
          LanguageViewItem(
              isSelected: selectedLanguage == Language.english,
              language: Language.english,
              icon: AppImage.icEnLang,
              onChange: onLangChange),
          LanguageViewItem(
              isSelected: selectedLanguage == Language.german,
              language: Language.german,
              icon: AppImage.icDeLang,
              onChange: onLangChange),
          Gap(AppHeight.s20),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              backGroundColor: AppColor.themeColor,
              label: context.text.change,
              onPressed: () async {
                final Language lang = Language.getLanguageByCode((selectedLanguage.languageCode));
                await widget.appSettings.setSelectedLanguage(lang);
                updateLocalization(lang);
                if(context.mounted){
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ChangeLanguage(selectedLanguage: lang));
                  context.pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Flexible(
      child: Text(
        context.text.select_preferred_language,
        style: context.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500, fontSize: AppTextSize.s18, color: AppColor.themeDeepBlackColor),
      ),
    );
  }
}
