import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/enums/date_range.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text(
            "U-Traffic Analytics",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Text(
            "Date Range",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 16),
          StatusTypeDropDown(
            statusList:
                DateRangeType.values.map((e) => e.name.capitalize).toList(),
            onChanged: (value) {
              ref.read(dateRangeTypeProvider.notifier).state = DateRangeType
                  .values
                  .firstWhere((element) => element.name.capitalize == value);
            },
            value: ref.watch(dateRangeTypeProvider).name.capitalize,
          ),
        ],
      ),
    );
  }
}
