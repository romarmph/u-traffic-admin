import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TrafficPostSelectionTile extends ConsumerWidget {
  const TrafficPostSelectionTile({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.name,
    required this.postNumber,
    required this.shift,
    this.enabled = false,
  });

  final bool isSelected;
  final void Function(bool? value) onChanged;
  final String name;
  final String postNumber;
  final String shift;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? UColors.blue200 : UColors.gray50,
          borderRadius: BorderRadius.circular(
            USpace.space8,
          ),
          border: Border.all(
            color: isSelected ? UColors.blue400 : UColors.gray300,
            width: 1,
          ),
        ),
        child: CheckboxListTile(
          enabled: enabled,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: USpace.space16,
            vertical: USpace.space8,
          ),
          value: isSelected,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  backgroundColor: UColors.blue500,
                  radius: 16,
                  child: Text(
                    postNumber,
                    style: const TextStyle(
                      color: UColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              const SizedBox(width: USpace.space8),
              Text(
                name,
                style: const TextStyle(
                  color: UColors.gray600,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Chip(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space4),
                ),
                backgroundColor: shift == 'morning'
                    ? UColors.indigo500
                    : shift == 'afternoon'
                        ? UColors.orange500
                        : UColors.blue900,
                label: Text(
                  shift.toUpperCase(),
                  style: const TextStyle(
                    color: UColors.white,
                  ),
                ),
              ),
            ],
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
