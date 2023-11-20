import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerSelectionTile extends ConsumerWidget {
  const EnforcerSelectionTile({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.name,
    required this.employeeNumber,
    required this.photoUrl,
  });

  final bool isSelected;
  final void Function(bool? value) onChanged;
  final String name;
  final String employeeNumber;
  final String photoUrl;

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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: USpace.space16,
            vertical: USpace.space8,
          ),
          value: isSelected,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: CachedNetworkImageProvider(
                  photoUrl,
                ),
              ),
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
                backgroundColor: UColors.blue500,
                label: Text(
                  employeeNumber,
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
