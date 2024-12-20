import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:flutter/material.dart';


final TextTheme appTextTheme = TextTheme(

  displayMedium: TextStyle(
      fontSize: AppTextSize.s16,
      fontWeight: FontWeight.w500,
      color: AppColor.themeColor),

  labelSmall: TextStyle(fontSize: AppTextSize.s12, fontWeight: FontWeight.w400),


  labelMedium: TextStyle(
      fontSize: AppTextSize.s14,
      fontWeight: FontWeight.w400),


  labelLarge: TextStyle(
      fontSize: AppTextSize.s14,
      fontWeight: FontWeight.w500),


  titleMedium: TextStyle(
      fontSize: AppTextSize.s24,
      fontWeight: FontWeight.w500),


  titleSmall: TextStyle(
      fontSize: AppTextSize.s14,
      fontWeight: FontWeight.w400),


  titleLarge: TextStyle(
      fontSize: AppTextSize.s20,
      fontWeight: FontWeight.w600),

  displaySmall:
      TextStyle(fontSize: AppTextSize.s12, fontWeight: FontWeight.w500),
);

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  textTheme: appTextTheme,
  useMaterial3: true
);
