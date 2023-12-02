import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/enums/date_range.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';
import 'package:u_traffic_admin/views/analytics/widgets/doughnut_chart.dart';
import 'package:u_traffic_admin/views/analytics/widgets/quick_info_card.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(ticketByStatusAggregateProvider);
    return PageContainer(
      route: Routes.analytics,
      appBar: AppBar(
        title: const Text("Analytics"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                          statusList: DateRangeType.values
                              .map((e) => e.name.capitalize)
                              .toList(),
                          onChanged: (value) {
                            ref.read(dateRangeTypeProvider.notifier).state =
                                DateRangeType.values.firstWhere((element) =>
                                    element.name.capitalize == value);
                          },
                          value:
                              ref.watch(dateRangeTypeProvider).name.capitalize,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: QuickInfoCard(
                          provider: totalTicketsAggregate,
                          title: "Total tickets",
                          icon: Icons.article_outlined,
                          color: UColors.blue600,
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
                          color: UColors.green600,
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
                          icon: Icons.paid_rounded,
                          color: UColors.red600,
                          isNegative: true,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: QuickInfoCard(
                          provider: paidVsUnpaidAggregateProvider,
                          title: "Paid tickets",
                          icon: Icons.paid_rounded,
                          color: UColors.green600,
                          isNegative: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DoughnutChart(
                          provider: ticketByStatusAggregateProvider,
                          title: "Tickets by Status",
                          name: "Tickets by Status",
                          legendTitle: "Ticket Status",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DoughnutChart(
                          provider: paidVsUnpaidAggregateProvider,
                          title: "Paid and Unpaid Tickets",
                          name: "Paid and Unpaid Tickets",
                          legendTitle: "Ticket Status",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Daily Ticket Issued",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        StatusTypeDropDown(
                          statusList: DateRangeType.values
                              .map((e) => e.name.capitalize)
                              .toList(),
                          onChanged: (value) {
                            ref.read(dateRangeTypeProvider.notifier).state =
                                DateRangeType.values.firstWhere((element) =>
                                    element.name.capitalize == value);
                          },
                          value:
                              ref.watch(dateRangeTypeProvider).name.capitalize,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
