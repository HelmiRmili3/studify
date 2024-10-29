import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  //NEW COLORS
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 34, 114, 233),
  scaffoldBackgroundColor: AppColors.lightBackground,
  buttonTheme: const ButtonThemeData(
    splashColor: AppColors.lightPrimary,
  ),
  textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: AppColors.lightTextColor,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkBleu,
      )),
  splashColor: Colors.white,
  canvasColor: const Color(0XFFE8F1FF),

  //OLD COLORS
  cardColor: const Color(0xff000000),
  shadowColor: Colors.black,
  highlightColor: Colors.white,
  dialogBackgroundColor: const Color(0xffD9D9D9),
  indicatorColor: Colors.black,
  dividerColor: Colors.white,
  hintColor: Colors.black,

  dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
  )),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffE1E1E1),
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData(
  //NEW COLORS
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  buttonTheme: const ButtonThemeData(
    splashColor: AppColors.darkPrimary,
  ),
  textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: AppColors.darkTextColor,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
      )),
  splashColor: Colors.transparent,
  //OLD COLORS
  cardColor: const Color(0xffF2F2F2),
  shadowColor: Colors.white,
  canvasColor: Colors.black,
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
    ),
  ),
  dialogBackgroundColor: const Color(0x54888888),
  hintColor: Colors.black.withOpacity(.6),
  indicatorColor: Colors.white,
  dividerColor: Colors.white,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
  ),
);
