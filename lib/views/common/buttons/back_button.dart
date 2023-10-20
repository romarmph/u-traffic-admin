import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UBackButton extends StatelessWidget {
  const UBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: UColors.gray600,
        padding: const EdgeInsets.only(
          right: 4,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      label: const Text("Back"),
    );
  }
}
