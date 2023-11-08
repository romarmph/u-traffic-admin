import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentHomePage extends ConsumerStatefulWidget {
  const PaymentHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentHomePageState();
}

class _PaymentHomePageState extends ConsumerState<PaymentHomePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          const StatusTypeDropDown(
                            statusList: [
                              'unpaid',
                              'paid',
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
                                ref.read(searchQueryProvider.notifier).state =
                                    value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: UColors.gray300,
                                ),
                                suffixIcon: Visibility(
                                  visible:
                                      ref.watch(searchQueryProvider).isNotEmpty,
                                  child: IconButton(
                                    onPressed: () {
                                      ref
                                          .read(searchQueryProvider.notifier)
                                          .state = '';
                                      searchController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.filter_list,
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
                ref.watch(getAllTicketByStatusStream).when(
                      data: (data) {
                        final query = ref.watch(searchQueryProvider);
                        return TicketDataGrid(
                          currentRoute: Routes.payment,
                          data: _searchTicket(data, query),
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
