import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: UColors.blue700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USpace.space8),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: USpace.space12,
      horizontal: USpace.space24,
    ),
    textStyle: const UTextStyle().textbasefontnormal,
  ),
);
