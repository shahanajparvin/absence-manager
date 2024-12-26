import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_constant.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';


mixin InputDecorationMixin {

  InputDecoration customInputDecoration({
    String? labelText,
    String? hintText,
    String? errorText,
    Color? fillColor,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    bool? isNoPrefixPadding,
    Widget? suffixIcon,
    bool isCollapsed = true,
    BorderRadius? borderRadius,
    Color? borderColor,
    required BuildContext context,

  }) {
    return InputDecoration(
      labelText: labelText,
      errorText: errorText,
      errorMaxLines: 3,
      fillColor: fillColor,
      filled: fillColor != null,
      hintText: hintText ?? '',
      errorStyle: _errorStyle(context),
      hintStyle: _hintStyle(context),
      enabledBorder: _getStrokeBorderStyle(color: borderColor ?? AppColor.lightGreyColor,borderRadius: borderRadius),
      focusedBorder: _getStrokeBorderStyle(color: borderColor ?? AppColor.lightGreyColor,borderRadius: borderRadius),
      errorBorder: _getStrokeBorderStyle(color:  AppColor.errorColor,borderRadius: borderRadius),
      focusedErrorBorder: _getStrokeBorderStyle(color: AppColor.errorColor,borderRadius: borderRadius),
      isCollapsed: isCollapsed,
      contentPadding:  EdgeInsets.symmetric(vertical:AppConst.textFieldVerticalPadding),
      prefix:  isNoPrefixPadding!=null?null:Padding(padding: EdgeInsets.only(left: AppConst.textFieldHorizontalPadding)),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      constraints: BoxConstraints(
        maxHeight: AppConst.textFieldHeight,
        minHeight: AppHeight.s40,
      ),
    );
  }

  Widget textFieldLabel(
      {required BuildContext context,
        required String? label,}) {
    return  Text(
      label!,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }


  OutlineInputBorder _getStrokeBorderStyle({ BorderRadius? borderRadius, required Color color}) {
    return OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(AppConst.textFieldBorderRadius),
      borderSide:
      BorderSide(width: AppWidth.s1, color: color),
    );
  }





  TextStyle _hintStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColor.darkGreyColor);
  }

  TextStyle _errorStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.errorColor);
  }


}
