import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    textStyle: const UTextStyle().textbasefontmedium,
    side: const BorderSide(
      color: UColors.blue500,
      width: 1.5,
    ),
    foregroundColor: UColors.blue500,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
