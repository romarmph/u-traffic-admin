import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDetailsPage extends ConsumerStatefulWidget {
  const TicketDetailsPage({
    super.key,
    required this.ticketID,
    required this.route,
  });

  final String ticketID;
  final String route;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TicketDetailsPageState();
}

class _TicketDetailsPageState extends ConsumerState<TicketDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ref.watch(getAllEvidenceProvider(
      widget.ticketID,
    ));
    return PageContainer(
      route: widget.route,
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
                  data: (data) => TicketDetails(
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