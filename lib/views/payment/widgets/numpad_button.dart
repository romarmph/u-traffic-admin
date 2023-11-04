import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class NumPadButton extends StatelessWidget {
  const NumPadButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(USpace.space4),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(USpace.space4),
            ),
            foregroundColor: UColors.gray500,
            backgroundColor: UColors.white,
            side: const BorderSide(
              color: UColors.gray300,
            ),
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
