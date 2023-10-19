import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final headerColor = isDarkMode ? UColors.gray700 : UColors.gray100;
    final headerFgColor = isDarkMode ? UColors.gray400 : UColors.gray500;
    final headerTextStyle = TextStyle(
      color: isDarkMode ? UColors.gray400 : UColors.gray500,
    );

    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: ref.watch(getAllTicketsStreamProvider).when(
        data: (data) {
          final TicketDataGridSource source = TicketDataGridSource(
            data,
            ref.watch(rowsPerPageProvider),
          );
          return Column(
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
                      strokeAlign: BorderSide.strokeAlignInside,
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
                      rowsPerPage: 10,
                      allowSorting: true,
                      columnWidthMode: ColumnWidthMode.fill,
                      gridLinesVisibility: GridLinesVisibility.none,
                      isScrollbarAlwaysShown: true,
                      rowHeight: 64,
                      showHorizontalScrollbar: true,
                      source: source,
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
                        GridColumn(
                          columnName: TicketGridFields.status,
                          label: Center(
                            child: Text(
                              'Actions',
                              style: headerTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SfDataPager(
                pageCount: 2,
                delegate: source,
              )
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TicketDataGridSource extends DataGridSource {
  TicketDataGridSource(this.tickets, this.rowsPerPage) {
    _paginatedTickets = tickets.getRange(0, rowsPerPage).toList();
    buildDataGridRows();
  }
  late int rowsPerPage;
  late List<Ticket> _paginatedTickets;
  late List<DataGridRow> dataGridRows;
  late List<Ticket> tickets;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          color: Colors.white,
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(growable: false),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex < tickets.length && endIndex <= tickets.length) {
      _paginatedTickets =
          tickets.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
      notifyListeners();
    } else {
      _paginatedTickets = tickets.getRange(startIndex, tickets.length).toList();
      buildDataGridRows();
      notifyListeners();
    }

    return true;
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRows() {
    dataGridRows = _paginatedTickets.map<DataGridRow>((ticket) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: TicketGridFields.ticketNumber,
            value: ticket.ticketNumber.toString(),
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.licenseNumber,
            value: ticket.licenseNumber,
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.driverName,
            value: ticket.driverName,
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.dateCreated,
            value: ticket.dateCreated.toAmericanDate,
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.totalFine,
            value: ticket.totalFine.toString(),
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.status,
            value: ticket.status.toString().split('.').last.toUpperCase(),
          ),
          DataGridCell<String>(
            columnName: TicketGridFields.actions,
            value: ticket.id,
          ),
        ],
      );
    }).toList(growable: false);
  }
}
