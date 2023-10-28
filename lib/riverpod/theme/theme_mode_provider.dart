import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final themeModeProvider = Provider<ThemeMode>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
});
