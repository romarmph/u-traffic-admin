import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketView extends ConsumerStatefulWidget {
  const TicketView({super.key, required this.ticketID, required this.route});

  final String ticketID;
  final String route;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<TicketView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      key: _scaffoldKey,
      route: widget.route,
      appBar: AppBar(
        title: const Text("View Ticket"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      endDrawer: Drawer(
        width: 500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(USpace.space8),
        ),
        backgroundColor: UColors.white,
        child: ref.watch(getTicketByIdFutureProvider(widget.ticketID)).when(
              data: (data) => EvidenceDrawer(
                ticketNumber: data.ticketNumber!,
              ),
              error: (error, stackTrace) {
                return Container(
                  color: UColors.white,
                  child: const Text(
                    'Error fetching ticket. Please try again later.',
                  ),
                );
              },
              loading: () {
                return Container(
                  color: UColors.white,
                  child: const Center(
                    child: LinearProgressIndicator(),
                  ),
                );
              },
            ),
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
                ref.watch(getTicketByIdFutureProvider(widget.ticketID)).when(
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
              ],
            ),
          );
        },
      ),
    );
  }
}
