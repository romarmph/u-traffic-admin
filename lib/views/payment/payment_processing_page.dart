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
      appBar: AppBar(
        title: const Text('Payment Processing'),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
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
                          child: ListView(
                            children: _buildViolationsList(),
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

  List<Widget> _buildViolationsList() {
    List<Widget> ticketViolations = [];

    for (var violation in ticket.issuedViolations) {
      ticketViolations.add(
        ListTile(
          title: Text(
            violation.violation,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: UColors.gray500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            children: [
              Text(
                violation.penalty,
                style: const TextStyle(
                  fontSize: 14,
                  color: UColors.gray500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: USpace.space4,
              ),
              Row(
                children: [
                  Text(
                    violation.isBigVehicle
                        ? "Big Vehicle"
                        : "Tricycle/Motorcycle",
                    style: const TextStyle(
                      fontSize: 14,
                      color: UColors.gray500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    violation.offense == 1
                        ? '1st Offense'
                        : violation.offense == 2
                            ? '2nd Offense'
                            : '3rd Offense',
                    style: TextStyle(
                      fontSize: 14,
                      color: violation.offense == 1
                          ? UColors.green500
                          : violation.offense == 2
                              ? UColors.yellow500
                              : UColors.red500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Text(
            "${violation.fine} PHP",
            style: const TextStyle(
              color: UColors.red400,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return ticketViolations;
  }
}
