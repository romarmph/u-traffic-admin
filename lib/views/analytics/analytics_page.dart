import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/aggregates/ticket.riverpod.dart';
import 'package:u_traffic_admin/views/analytics/widgets/pie_chart.dart';

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
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Analytics",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title for ticket data
                    const Text(
                      "Tickets",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PieChartWidget(
                            provider: ticketByStatusAggregateProvider,
                            title: "Number of Tickets by Status",
                            name: "Number of Tickets by Status",
                            legendTitle: "Ticket Status",
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: Container(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: Container(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
