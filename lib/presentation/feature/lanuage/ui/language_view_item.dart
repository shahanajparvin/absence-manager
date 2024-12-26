

import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_image.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/common/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class LanguageViewItem extends StatelessWidget {
  final Language language;
  final String icon;
  final Function(Language) onChange;
  final bool isSelected;

  const LanguageViewItem({
    super.key,
    required this.language,
    required this.icon,
    required this.onChange,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColor.splashColor,
        borderRadius: BorderRadius.circular(AppRound.s5),
        onTap: () {
          onChange(language);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s2,vertical: AppHeight.s5),
          child: Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(icon),
                    width: AppWidth.s32,
                    height: AppHeight.s32,
                  ),
                   SizedBox(width: AppWidth.s8),
                  // Changed Gap to SizedBox for standard practice
                  Text(
                    Language.getLocalizedLanguageName(
                        context, language.languageCode),
                    style: context.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: AppTextSize.s14,
                      color: AppColor.themeDeepBlackColor
                    ),
                  ),
                ],
              ),


               Padding(
                  padding: EdgeInsets.all(AppWidth.s8),
                  child: AppIcon(assetName: isSelected?AppImage.icSelectRadio:AppImage.icUnselectRadio)),
            ],
          ),
        ),
      ),
    );
  }
}
