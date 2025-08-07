import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColors.mainColor,
  scaffoldBackgroundColor: const Color(0xffF5F5F5),
  fontFamily: 'Ar',
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: AppColors.mainColor,
    ),
  ),
);
