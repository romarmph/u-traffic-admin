import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final tabControllerProvider = StateProvider<TabController>((ref) {
  return TabController(
    length: 2,
    vsync: ref.read(vsyncProvider),
  );
});

final vsyncProvider = Provider<TickerProvider>((ref) {
  return navigatorKey.currentState!;
});

class PaymentHomePage extends ConsumerWidget {
  const PaymentHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.payment,
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              controller: ref.watch(tabControllerProvider),
                              tabs: const [
                                Tab(
                                  text: 'Unpaid',
                                ),
                                Tab(
                                  text: 'Paid',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: constraints.maxHeight - 100 - 50,
                  width: constraints.maxWidth,
                  child: TabBarView(
                    controller: ref.watch(tabControllerProvider),
                    children: [
                      ref
                          .watch(getAllUnpaidTicketsStreamProvider('unpaid'))
                          .when(
                            data: (data) {
                              return TicketDataGrid(
                                currentRoute: Routes.payment,
                                data: data,
                                constraints: constraints,
                              );
                            },
                            error: (error, stackTrace) {
                              return const Center(
                                child: Text('Error'),
                              );
                            },
                            loading: () => const Center(
                              child: LinearProgressIndicator(),
                            ),
                          ),
                      ref.watch(getAllUnpaidTicketsStreamProvider('paid')).when(
                            data: (data) {
                              return TicketDataGrid(
                                currentRoute: Routes.payment,
                                data: data,
                                constraints: constraints,
                              );
                            },
                            error: (error, stackTrace) {
                              return const Center(
                                child: Text('Error'),
                              );
                            },
                            loading: () => const Center(
                              child: LinearProgressIndicator(),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
