import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemMenuButton extends StatelessWidget {
  const SystemMenuButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ? UColors.blue600 : UColors.white,
        padding: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(USpace.space8),
        ),
      ),
      onPressed: onTap,
      label: Text(
        title,
        style: TextStyle(
          color: isActive ? UColors.white : UColors.gray600,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      icon: Icon(
        icon,
        color: isActive ? UColors.white : UColors.gray600,
      ),
    );
  }
}
