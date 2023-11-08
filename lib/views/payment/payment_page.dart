import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentHomePage extends ConsumerStatefulWidget {
  const PaymentHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentHomePageState();
}

class _PaymentHomePageState extends ConsumerState<PaymentHomePage>
    with SingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    super.initState();
  }

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
                              controller: _tabController,
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
                          Visibility(
                            visible: _currentTabIndex == 0,
                            child: const StatusTypeDropDown(
                              statusList: [
                                'unpaid',
                                'paid',
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Visibility(
                            visible: _currentTabIndex == 0,
                            child: SizedBox(
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
                                    visible: ref
                                        .watch(searchQueryProvider)
                                        .isNotEmpty,
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
                    controller: _tabController,
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
                      ref.watch(paymentStreamProvider).when(
                            data: (data) {
                              final query = ref.watch(searchQueryProvider);
                              return DataGridContainer(
                                source: PaymentDataGridSource(
                                  paymentList:
                                      _searchPaymentHistory(data, query),
                                  currentRoute: Routes.payment,
                                ),
                                dataCount:
                                    _searchPaymentHistory(data, query).length,
                                gridColumns: paymentGridColumn,
                                constraints: constraints,
                              );
                            },
                            error: (error, stackTrace) {
                              return const Center(
                                child: Text('Error fetching payment history'),
                              );
                            },
                            loading: () => SizedBox(
                              height: constraints.maxHeight - 100 - 64,
                              child: const Center(
                                child: LinearProgressIndicator(),
                              ),
                            ),
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

  List<PaymentDetail> _searchPaymentHistory(
    List<PaymentDetail> history,
    String query,
  ) {
    if (query.isNotEmpty) {
      return history.where((payment) {
        query = query.toLowerCase();
        return payment.ticketNumber.toString().contains(query) ||
            payment.processedBy.toLowerCase().contains(query) ||
            payment.processedAt.toAmericanDate.toLowerCase().contains(query) ||
            payment.change.toString().contains(query) ||
            payment.fineAmount.toString().contains(query) ||
            payment.tenderedAmount.toString().contains(query);
      }).toList();
    }
    return history;
  }
}
