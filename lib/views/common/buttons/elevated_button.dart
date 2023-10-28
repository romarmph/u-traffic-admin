import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UElevatedButton extends StatelessWidget {
  const UElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: UColors.blue600,
            foregroundColor: UColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(USpace.space8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: USpace.space24,
              horizontal: USpace.space24,
            ),
            textStyle: const UTextStyle().textbasefontmedium,
          ),
      child: child,
    );
  }
}
