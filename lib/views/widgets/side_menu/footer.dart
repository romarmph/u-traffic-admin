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
    if (isCompact) {
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
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: UColors.gray600,
            padding: const EdgeInsets.all(USpace.space24),
          ),
          onPressed: () {},
          label: const Text('Logout'),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
