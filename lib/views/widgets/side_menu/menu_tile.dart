import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SideMenuItemTile extends ConsumerWidget {
  const SideMenuItemTile({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(selectedRouteProvider);
    final isSelected = currentRoute == route;
    final isDarkMode = ref.watch(isDarkModeProvider);
    final fgColor = isDarkMode ? UColors.gray300 : UColors.gray500;

    final deviceWidth = MediaQuery.of(context).size.width;
    final isCompact = deviceWidth <= 600;

    void changePage() {
      ref.read(selectedRouteProvider.notifier).update((state) => route);
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 0 : USpace.space12,
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Material(
          color: isSelected ? UColors.blue700 : Colors.transparent,
          child: InkWell(
            splashColor: UColors.blue600,
            onTap: changePage,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 0 : USpace.space12,
                vertical: USpace.space12,
              ),
              child: Row(
                mainAxisAlignment: isCompact
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? UColors.white : fgColor,
                  ),
                  SizedBox(width: isCompact ? 0 : USpace.space8),
                  isCompact
                      ? const SizedBox.shrink()
                      : Text(
                          title,
                          style: const UTextStyle().textsmfontnormal.copyWith(
                                color: isSelected ? UColors.white : fgColor,
                              ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
