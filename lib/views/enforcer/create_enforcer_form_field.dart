import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerFormField extends StatelessWidget {
  const EnforcerFormField({
    super.key,
    this.controller,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.enabled,
    this.obscureText = false,
    this.onChanged,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;
  final bool? enabled;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? initialValue;

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
          initialValue: initialValue,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          enabled: enabled,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
