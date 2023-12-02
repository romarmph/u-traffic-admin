import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/daily_dart_data.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';
import 'package:u_traffic_admin/views/analytics/widgets/dashboard_header.dart';
import 'package:u_traffic_admin/views/analytics/widgets/doughnut_chart.dart';
import 'package:u_traffic_admin/views/analytics/widgets/quick_info_row.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    final columnRange = ref.watch(columnRangeProvider);

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
                  const DashboardHeader(),
                  const SizedBox(height: 16),
                  const QuickInfoRow(),
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
                        Text(
                          "${columnRange.capitalize} Ticket Issued",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        StatusTypeDropDown(
                          statusList: const [
                            "Daily",
                            "Monthly",
                            "Yearly",
                          ],
                          onChanged: (value) {
                            ref.read(columnRangeProvider.notifier).state =
                                value!.toLowerCase();
                          },
                          value: ref.watch(columnRangeProvider).capitalize,
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
                    child: ref.watch(ticketsColumnChartProvider).when(
                          data: (data) {
                            if (columnRange == 'daily') {
                              data = data.reversed.toList();
                            }
                            return SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                ColumnSeries<ColumnDataChart, String>(
                                  dataSource: data,
                                  xValueMapper: (ColumnDataChart data, _) =>
                                      data.column,
                                  yValueMapper: (ColumnDataChart data, _) =>
                                      data.count,
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                  ),
                                )
                              ],
                            );
                          },
                          error: (error, stackTrace) => Center(
                            child: Text(
                              error.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
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

