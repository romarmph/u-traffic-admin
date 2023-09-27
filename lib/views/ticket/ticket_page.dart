import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Ticket> tickets = ref.watch(fetchedTicketsProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    final headerColor = isDarkMode ? UColors.gray700 : UColors.gray100;
    final headerFgColor = isDarkMode ? UColors.gray400 : UColors.gray500;
    final headerTextStyle = TextStyle(
      color: isDarkMode ? UColors.gray400 : UColors.gray500,
    );

    return ContentView(
      appBar: const CustomAppBar(
        title: Text('Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: isDarkMode ? UColors.gray800 : Colors.white,
                  borderRadius: BorderRadius.circular(USpace.space12),
                  border: Border.all(
                    color: isDarkMode ? UColors.gray700 : UColors.gray200,
                    width: 2,
                  ),
                ),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: headerColor,
                    sortIconColor: headerFgColor,
                    filterIconColor: headerFgColor,
                  ),
                  child: SfDataGrid(
                    allowFiltering: true,
                    allowSorting: true,
                    columnWidthMode: ColumnWidthMode.fill,
                    gridLinesVisibility: GridLinesVisibility.none,
                    isScrollbarAlwaysShown: true,
                    rowHeight: 64,
                    showHorizontalScrollbar: true,
                    source: TicketDataSource(
                      ticketdata: tickets,
                      ref: ref,
                    ),
                    columns: [
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        columnName: TicketGridFields.ticketNumber,
                        label: Center(
                          child: Text(
                            'Ticket No.',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: TicketGridFields.licenseNumber,
                        label: Center(
                          child: Text(
                            'License No.',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: TicketGridFields.driverName,
                        label: Center(
                          child: Text(
                            'Driver Name',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: TicketGridFields.dateCreated,
                        label: Center(
                          child: Text(
                            'Date Issued',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: TicketGridFields.totalFine,
                        label: Center(
                          child: Text(
                            'Fina Amount',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: TicketGridFields.status,
                        label: Center(
                          child: Text(
                            'Status',
                            style: headerTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DataGridPager(
              delegate: TicketDataSource(
                ticketdata: ref.watch(fetchedTicketsProvider),
                ref: ref,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataGridPager extends ConsumerWidget {
  const DataGridPager({
    super.key,
    required this.delegate,
  });

  final DataPagerDelegate delegate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Ticket> tickets = ref.watch(fetchedTicketsProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    final backgroundColor = isDarkMode ? UColors.gray800 : UColors.white;
    const itemTextStyle = TextStyle(
      color: UColors.gray500,
    );

    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        backgroundColor: backgroundColor,
        itemTextStyle: itemTextStyle,
        disabledItemTextStyle: itemTextStyle,
      ),
      child: SfDataPager(
        visibleItemsCount: 10,
        direction: Axis.horizontal,
        previousPageItemVisible: true,
        pageCount: tickets.isEmpty ? 1 : tickets.length / 10,
        delegate: delegate,
      ),
    );
  }
}
