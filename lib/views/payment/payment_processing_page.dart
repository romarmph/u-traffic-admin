import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentProcessingPage extends ConsumerWidget {
  const PaymentProcessingPage({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.payment,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UBackButton(),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PreviewListTile(
                                title: ticket.ticketNumber.toString(),
                                subtitle: 'Ticket Number',
                              ),
                            ),
                            Expanded(
                              child: PreviewListTile(
                                title: ticket.driverName ?? "N/A",
                                subtitle: 'Driver Name',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PreviewListTile(
                                title: ticket.licenseNumber ?? 'N/A',
                                subtitle: 'License Number',
                              ),
                            ),
                            Expanded(
                              child: PreviewListTile(
                                title: ticket.enforcerName,
                                subtitle: 'Enforcer',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        const Text(
                          "Violations",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: ticket.violationsID.length,
                            itemBuilder: (context, index) {
                              final violationList = ref.watch(
                                violationsProvider,
                              );
                              final violation = violationList.where(
                                (element) =>
                                    element.id == ticket.violationsID[index],
                              );
                              return ListTile(
                                title: Text(
                                  violation.first.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: UColors.gray500,
                                  ),
                                ),
                                trailing: Text(
                                  violation.first.fine.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: UColors.red500,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: USpace.space16,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: USpace.space16,
                  ),
                  NumPad(
                    ticket: ticket,
                    constraints: constraints,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
