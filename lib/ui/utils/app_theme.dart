import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.white);

  static const TextStyle taskTitleTextStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primiary);

  static const TextStyle taskDescriptionTextStyle =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: AppColors.lightBlack);

  static const TextStyle bottomSheetTitleTextStyle =
  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.lightBlack);

  static ThemeData lightTheme = ThemeData(
  dividerTheme: DividerThemeData(
    thickness: 3,color: AppColors.primiary
  ),
    primaryColor: AppColors.primiary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primiary,
      elevation: 0,
      titleTextStyle: appBarTextStyle
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size:32 ),
      unselectedIconTheme: IconThemeData(size: 32),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primiary,
      unselectedItemColor: AppColors.grey,

    ),
  scaffoldBackgroundColor: AppColors.accent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(
              color: AppColors.white,
              width: 4,
            )
  ),
  ));
  static ThemeData darkTheme =ThemeData();


}