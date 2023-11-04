import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

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
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ref.watch(getAllUnpaidTicketsStreamProvider).when(
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
          );
        },
      ),
    );
  }
}
