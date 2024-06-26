import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PreviewListTile extends StatelessWidget {
  const PreviewListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
  });

  final String title;
  final String subtitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(USpace.space8),
      ),
      elevation: 0,
      color: UColors.gray50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: UColors.gray400,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: title.isEmpty ? UColors.gray400 : UColors.gray800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
