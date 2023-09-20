import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: UColors.blue600,
    foregroundColor: UColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USpace.space8),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: USpace.space16,
      horizontal: USpace.space24,
    ),
    textStyle: const UTextStyle().textbasefontmedium,
  ),
);
