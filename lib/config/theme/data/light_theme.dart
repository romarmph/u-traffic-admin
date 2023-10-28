import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: UColors.blue600,
  ),
  useMaterial3: true,
  fontFamily: GoogleFonts.inter().fontFamily,
  inputDecorationTheme: inputDecorationTheme,
  textButtonTheme: textButtonTheme,
  floatingActionButtonTheme: fabTheme,
  appBarTheme: appBarTheme,
  scaffoldBackgroundColor: UColors.white,
);
