import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class StatusTypeDropDown extends ConsumerWidget {
  const StatusTypeDropDown({
    super.key,
    required this.statusList,
    required this.onChanged,
    required this.value,
  });

  final List<String> statusList;
  final void Function(String? value)? onChanged;
  final String value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space8),
        border: Border.all(
          color: UColors.gray300,
        ),
      ),
      child: DropdownButton(
          underline: const SizedBox.shrink(),
          borderRadius: BorderRadius.circular(USpace.space8),
          onChanged: onChanged,
          value: value,
          isExpanded: true,
          items: statusList.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e.capitalize,
              ),
            );
          }).toList()),
    );
  }
}
