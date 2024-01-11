import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';
import 'package:u_traffic_admin/views/analytics/widgets/quick_info_card.dart';

class QuickInfoRow extends StatelessWidget {
  const QuickInfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickInfoCard(
            provider: totalTicketsAggregate,
            title: "Total tickets",
            icon: Icons.article_outlined,
            color: UColors.blue400,
            isNegative: true,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: QuickInfoCard(
            provider: paidTicketsAggregateProvider,
            title: "Paid tickets",
            icon: Icons.paid_rounded,
            color: UColors.green400,
            isNegative: false,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: QuickInfoCard(
            provider: unpaidTicketsAggregateProvider,
            title: "Unpaid tickets",
            icon: Icons.pending_actions_outlined,
            color: UColors.red400,
            isNegative: true,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: QuickInfoCard(
            provider: cancelledTicketsAggregateProvider,
            title: "Cancelled tickets",
            icon: Icons.cancel_outlined,
            color: UColors.purple400,
            isNegative: true,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: QuickInfoCard(
            provider: overdueTicketsAggregateProvider,
            title: "Overdue tickets",
            icon: Icons.free_cancellation_rounded,
            color: UColors.yellow400,
            isNegative: true,
          ),
        ),
      ],
    );
  }
}
