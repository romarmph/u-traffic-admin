import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentTicketDetailsPage extends ConsumerStatefulWidget {
  const PaymentTicketDetailsPage({
    super.key,
    required this.ticketID,
  });

  final String ticketID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentTicketDetailsPageState();
}

class _PaymentTicketDetailsPageState
    extends ConsumerState<PaymentTicketDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ref.watch(getAllEvidenceProvider(
      widget.ticketID,
    ));
    return PageContainer(
      route: Routes.payment,
      endDrawer: Drawer(
        width: 500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(USpace.space8),
        ),
        backgroundColor: UColors.white,
        child: EvidenceDrawer(
          ticketID: widget.ticketID,
        ),
      ),
      appBar: AppBar(
        title: const Text("Process Payment"),
        actions: [
          Container(),
        ],
      ),
      scaffoldKey: _scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: ref
                .watch(
                  getTicketByIdFutureProvider(
                    widget.ticketID,
                  ),
                )
                .when(
                  data: (data) => PayTicketDetailView(
                    scaffoldKey: _scaffoldKey,
                    constraints: constraints,
                    ticket: data,
                  ),
                  error: (error, stackTrace) {
                    return Container(
                      color: UColors.white,
                      height: constraints.maxHeight - 100 - 16,
                      child: const Text(
                        'Error fetching ticket. Please try again later.',
                      ),
                    );
                  },
                  loading: () {
                    return Container(
                      color: UColors.white,
                      height: constraints.maxHeight - 100 - 16,
                      child: const Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
