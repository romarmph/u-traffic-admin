import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final relatedTicketStatusProvider = StateProvider<String>((ref) {
  return 'all';
});

class RelatedTicketsPage extends ConsumerStatefulWidget {
  const RelatedTicketsPage({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RelatedTicketsPageState();
}

class _RelatedTicketsPageState extends ConsumerState<RelatedTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.ticketView,
      appBar: AppBar(
        title: const Text("Related Tickets"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ref.watch(relatedTicketsStreamProvider(widget.ticket)).when(
                data: (data) {
              List<Ticket> gridData = data;

              final status = ref.watch(relatedTicketStatusProvider);
              if (status != 'all') {
                gridData = gridData
                    .where((element) =>
                        element.status.name.toLowerCase() ==
                        status.toLowerCase())
                    .toList();
              }
              return Column(
                children: [
                  SizedBox(
                    height: 100,
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
                            'Found ${data.length} related tickets',
                            style: const UTextStyle().text2xlfontnormal,
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: USpace.space16,
                          ),
                          StatusTypeDropDown(
                            statusList: const [
                              'all',
                              'unpaid',
                              'paid',
                              'cancelled',
                              'overdue',
                            ],
                            onChanged: (value) {
                              ref
                                  .read(relatedTicketStatusProvider.notifier)
                                  .state = value!;
                            },
                            value: ref.watch(relatedTicketStatusProvider),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: USpace.space16,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                      ),
                      child: DataGridContainer(
                        constraints: constraints,
                        source: TicketDataGridSource(
                          ref: ref,
                          ticketList: gridData,
                          currentRoute: Routes.ticketRelated,
                        ),
                        gridColumns: ticketGridColumns,
                        dataCount: data.length,
                      ),
                    ),
                  ),
                ],
              );
            }, error: (error, stackTrace) {
              return const SizedBox(
                child: Text(
                  'Error fetching tickets. Please try again later.',
                ),
              );
            }, loading: () {
              return Container(
                color: UColors.white,
                child: const Center(
                  child: LinearProgressIndicator(),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
