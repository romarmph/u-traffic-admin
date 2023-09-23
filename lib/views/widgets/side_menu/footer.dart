import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SideMenuFooter extends ConsumerWidget {
  const SideMenuFooter({
    super.key,
    required this.isCompact,
  });

  final bool isCompact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget compactLogoutButton() {
      if (isCompact) {
        return IconButton(
          color: UColors.gray600,
          onPressed: () {},
          icon: const Icon(
            Icons.logout,
          ),
        );
      }

      return IconButton(
        color: UColors.gray600,
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SideMenuDivider(),
        const SizedBox(height: USpace.space12),
        const Center(child: ThemeToggleButton()),
        const SizedBox(height: USpace.space12),
        compactLogoutButton(),
      ],
    );
  }
}
