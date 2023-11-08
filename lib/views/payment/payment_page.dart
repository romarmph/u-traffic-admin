import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final tabController = StateProvider<TabController>((ref) {
  return TabController(length: 2, vsync: ref.read(vsyncProvider));
});

final vsyncProvider = Provider<TickerProvider>((ref) {
  return navigatorKey.currentState!;
});

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
                          SizedBox(
                            width: 400,
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: ref.watch(tabController),
                              tabs: const [
                                Tab(
                                  text: 'Tickets',
                                ),
                                Tab(
                                  text: 'Payment History',
                                ),
                              ],
                            ),
                          ),
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
                SizedBox(
                  height: constraints.maxHeight - 50 - 100,
                  child: TabBarView(
                    controller: ref.watch(tabController),
                    children: [
                      ref.watch(getAllTicketByStatusStream).when(
                            data: (data) {
                              final query = ref.watch(searchQueryProvider);
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
                      Container(
                        color: Colors.red,
                      ),
                    ],
                  ),
                )
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
