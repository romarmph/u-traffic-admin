import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/enums/date_range.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';

class QuickInfoCard extends ConsumerWidget {
  const QuickInfoCard({
    super.key,
    required this.provider,
    required this.title,
    required this.icon,
    required this.color,
    this.reverse = false,
    required this.isNegative,
  });

  final StreamProvider<List<ChartData>> provider;
  final String title;
  final IconData icon;
  final Color color;
  final bool reverse;

  /// This is used to determine if the growth rate is positive or negative
  final bool isNegative;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ref.watch(provider).when(
            data: (data) {
              if (reverse) {
                data = data.reversed.toList();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    subtitle: Text(
                      data.first.count.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: UColors.gray50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 32,
                      ),
                    ),
                  ),
                  GrowthRate(
                    currentData: data.first.count.toDouble(),
                    previousData: data.last.count.toDouble(),
                    isNegative: isNegative,
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) {
              return const Center(
                child: Text(
                  'Error fetching data',
                ),
              );
            },
          ),
    );
  }
}

class GrowthRate extends ConsumerWidget {
  const GrowthRate({
    super.key,
    required this.currentData,
    required this.previousData,
    required this.isNegative,
  });

  final double currentData;
  final double previousData;
  final bool isNegative;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rate = getGrowthRate(currentData, previousData);
    final dateRangeType = ref.watch(dateRangeTypeProvider);

    if (rate == 0) {
      if (dateRangeType == DateRangeType.all) {
        return const Text(
          'All time data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: UColors.gray400,
          ),
        );
      }

      if (dateRangeType == DateRangeType.today) {
        return const Text(
          'No changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: UColors.gray400,
          ),
        );
      }

      return Text(
        'No change since last ${dateRangeType.name}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: UColors.gray400,
        ),
      );
    }

    if (rate > 0) {
      if (dateRangeType == DateRangeType.today) {
        return Text(
          '+${rate.toStringAsFixed(1)}% Since yesterday',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isNegative ? UColors.red500 : UColors.green500,
          ),
        );
      }

      return Text(
        dateRangeType == DateRangeType.all
            ? 'All time data'
            : '+${rate.toStringAsFixed(1)}% Since last ${dateRangeType.name}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: dateRangeType == DateRangeType.all
              ? UColors.gray400
              : isNegative
                  ? UColors.red500
                  : UColors.green500,
        ),
      );
    }

    if (dateRangeType == DateRangeType.today) {
      return Text(
        '${rate.toStringAsFixed(1)}% Since yesterday',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isNegative ? UColors.red500 : UColors.green500,
        ),
      );
    }

    return Text(
      dateRangeType == DateRangeType.all
          ? 'All time data'
          : '${rate.toStringAsFixed(1)}% Since last ${dateRangeType.name}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: dateRangeType == DateRangeType.all
            ? UColors.gray400
            : isNegative
                ? UColors.red500
                : UColors.green500,
      ),
    );
  }

  double getGrowthRate(double current, double previous) {
    if (previous == 0.0) {
      return current != 0.0 ? 100.0 : 0.0;
    } else {
      return (current - previous) / previous * 100;
    }
  }
}
