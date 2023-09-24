import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.clipBehavior,
  });

  final Widget? leading;
  final bool automaticallyImplyLeading = true;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final ScrollNotificationPredicate notificationPredicate =
      defaultScrollNotificationPredicate;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary = true;
  final bool? centerTitle;
  final bool excludeHeaderSemantics = false;
  final double? titleSpacing;
  final double toolbarOpacity = 1.0;
  final double bottomOpacity = 1.0;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency = false;
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final backgroundColor = isDarkMode ? UColors.gray700 : UColors.white;
    final foregroundColor = isDarkMode ? UColors.white : UColors.gray800;
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          USpace.space12,
        ),
      ),
    );
  }
}
