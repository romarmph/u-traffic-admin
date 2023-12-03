import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/analytics/widgets/dashboard_header.dart';
import 'package:u_traffic_admin/views/analytics/widgets/quick_info_row.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;

    return PageContainer(
      route: Routes.home,
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DashboardHeader(),
                const SizedBox(height: USpace.space16),
                const QuickInfoRow(),
                const SizedBox(height: USpace.space16),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USpace.space16),
                    ),
                    child: Column(
                      children: [
                        // Title
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: UColors.gray100,
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Tickets",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ref.watch(allTicketsTodayPRovider).when(
                              data: (data) {
                                return DataGridContainer(
                                  constraints: constraints,
                                  height: constraints.maxHeight -
                                      appBarHeight -
                                      320,
                                  source: TicketDataGridSource(
                                    ref: ref,
                                    ticketList: data,
                                    currentRoute: Routes.home,
                                  ),
                                  gridColumns: ticketGridColumns,
                                  dataCount: data.length,
                                );
                              },
                              error: (error, stackTrace) {
                                return Center(
                                  child: Text(
                                    error.toString(),
                                  ),
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
