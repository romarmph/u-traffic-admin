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
                            statusList: TicketStatus.values
                                .map((e) => e.toString().split('.').last)
                                .toList(),
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
                        if (data.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: UColors.white,
                                borderRadius:
                                    BorderRadius.circular(USpace.space16),
                              ),
                              height: constraints.maxHeight - 100 - 64 - 16,
                              child: const Center(
                                child: Text('No tickets found'),
                              ),
                            ),
                          );
                        }

                        return TicketDataGrid(
                          currentRoute: Routes.tickets,
                          data: data,
                          constraints: constraints,
                        );
                      },
                      error: (error, stackTrace) => const Center(
                        child: Text('Error'),
                      ),
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
}
