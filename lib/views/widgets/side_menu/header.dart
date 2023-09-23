import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SideMenuHeader extends ConsumerWidget {
  const SideMenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final deviceWidth = MediaQuery.of(context).size.width;
    final isCompact = deviceWidth <= 600;
    // ignore: unused_local_variable
    final bgColor = isDarkMode ? UColors.gray800 : UColors.white;
    final fgColor = isDarkMode ? UColors.gray300 : UColors.gray800;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(USpace.space8),
        child: Row(
          mainAxisAlignment:
              isCompact ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/app_logo.png',
              width: isCompact ? 32 : 48,
            ),
            SizedBox(width: isCompact ? 0 : USpace.space12),
            isCompact
                ? const SizedBox.shrink()
                : Text(
                    'U-Traffic Admin',
                    style: const UTextStyle().textxlfontmedium.copyWith(
                          color: fgColor,
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
