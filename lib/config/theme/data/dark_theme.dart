import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: UColors.blue600,
  ),
  useMaterial3: true,
  fontFamily: GoogleFonts.inter().fontFamily,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
  textButtonTheme: textButtonTheme,
  floatingActionButtonTheme: fabTheme,
  appBarTheme: appBarTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  scaffoldBackgroundColor: UColors.gray800,
);
