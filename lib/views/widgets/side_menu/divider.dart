import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SideMenuDivider extends ConsumerWidget {
  const SideMenuDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(isDarkModeProvider) ? UColors.gray700 : UColors.gray200;
    return Divider(
      height: 12,
      color: color,
      thickness: 1,
    );
  }
}
