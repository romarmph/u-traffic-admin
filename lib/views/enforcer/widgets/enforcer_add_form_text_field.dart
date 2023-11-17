import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerFormField extends StatelessWidget {
  const EnforcerFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.enabled,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: UColors.gray400,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: USpace.space8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: validator,
          enabled: enabled,
        ),
      ],
    );
  }
}
