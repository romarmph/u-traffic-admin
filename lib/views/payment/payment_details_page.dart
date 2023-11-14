import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDetailsPage extends ConsumerWidget {
  const PaymentDetailsPage({
    super.key,
    required this.ticketID,
  });

  final String ticketID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight = AppBar().preferredSize.height;
    return PageContainer(
      route: Routes.payment,
      appBar: AppBar(
        title: const Text('Payment Details'),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ref.watch(getPaymentByTicketID(ticketID)).when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(USpace.space12),
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: UColors.white,
                            borderRadius: BorderRadius.circular(USpace.space16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const UBackButton(),
                              const SizedBox(
                                width: USpace.space16,
                              ),
                              Text(
                                "Ticket Number: ",
                                style: const UTextStyle()
                                    .leadingnonetextlgfontsemibold,
                              ),
                              Text(
                                data.ticketNumber.toString(),
                                style: const UTextStyle().textlgfontmedium,
                              ),
                              const Spacer(),
                              UElevatedButton(
                                onPressed: () {
                                  goToTicketView(
                                    data.ticketID,
                                    Routes.payment,
                                  );
                                },
                                child: const Text("View Ticket"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(USpace.space16),
                      child: Container(
                        height: constraints.maxHeight - 100 - appBarHeight - 16,
                        padding: const EdgeInsets.all(USpace.space16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Column(
                          children: [
                            PreviewListTile(
                              title: data.method
                                  .toString()
                                  .split('.')
                                  .last
                                  .capitalize,
                              subtitle: 'Payment Method',
                            ),
                            PreviewListTile(
                              title: data.fineAmount.toString(),
                              subtitle: 'Fine Amount',
                            ),
                            PreviewListTile(
                              title: data.tenderedAmount.toString(),
                              subtitle: 'Tendered Amount',
                            ),
                            PreviewListTile(
                              title: data.change.toString(),
                              subtitle: 'Change',
                            ),
                            PreviewListTile(
                              title: data.processedByName.capitalize,
                              subtitle: 'Cashier',
                            ),
                            PreviewListTile(
                              title: data.processedAt.toAmericanDate,
                              subtitle: 'Date Paid',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error fetching payment details"),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
