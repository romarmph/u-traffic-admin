import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text('Tickets'),
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          StatusTypeDropDown(
                            value: ref.watch(
                              ticketViewStatusQueryProvider,
                            ),
                            onChanged: (value) {
                              ref
                                  .read(ticketViewStatusQueryProvider.notifier)
                                  .state = value!;
                            },
                            statusList: const [
                              'all',
                              'unpaid',
                              'paid',
                              'cancelled',
                              'refunded',
                              'submitted',
                              'expired',
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                ref
                                    .read(
                                        ticketViewSearchQueryProvider.notifier)
                                    .state = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: UColors.gray300,
                                ),
                                suffixIcon: Visibility(
                                  visible: ref
                                      .watch(ticketViewSearchQueryProvider)
                                      .isNotEmpty,
                                  child: IconButton(
                                    onPressed: () {
                                      ref
                                          .read(ticketViewSearchQueryProvider
                                              .notifier)
                                          .state = '';
                                      searchController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: UColors.gray300,
                                    ),
                                  ),
                                ),
                              ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: ref.watch(getAllTicketsForTicketPage).when(
                        data: (data) {
                          final query =
                              ref.watch(ticketViewSearchQueryProvider);
                          return DataGridContainer(
                            source: TicketDataGridSource(
                              ticketList: _searchTicket(data, query),
                              currentRoute: Routes.payment,
                            ),
                            dataCount: _searchTicket(data, query).length,
                            gridColumns: ticketGridColumns,
                            constraints: constraints,
                          );
                        },
                        error: (error, stackTrace) {
                          return const Center(
                            child: Text('Error fetching tickets'),
                          );
                        },
                        loading: () => SizedBox(
                          height: constraints.maxHeight - 100 - 64,
                          child: const Center(
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Ticket> _searchTicket(List<Ticket> tickets, String query) {
    if (query.isNotEmpty) {
      return tickets.where((ticket) {
        query = query.toLowerCase();
        return ticket.ticketNumber.toString().contains(query) ||
            ticket.driverName!.toLowerCase().contains(query) ||
            ticket.licenseNumber!.toLowerCase().contains(query) ||
            ticket.enforcerName.toLowerCase().contains(query) ||
            ticket.dateCreated.toAmericanDate.toLowerCase().contains(query) ||
            ticket.ticketDueDate.toAmericanDate.toLowerCase().contains(query);
      }).toList();
    }
    return tickets;
  }
}
