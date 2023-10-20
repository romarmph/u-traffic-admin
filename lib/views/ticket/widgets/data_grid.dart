import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataGrid extends ConsumerWidget {
  const TicketDataGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final headerColor = isDarkMode ? UColors.gray700 : UColors.gray100;
    final headerFgColor = isDarkMode ? UColors.gray400 : UColors.gray500;

    return ref.watch(getAllTicketsStreamProvider).when(
          data: (data) {
            final TicketDataGridSource source = TicketDataGridSource(
              data,
              ref.watch(rowsPerPageProvider),
            );
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: isDarkMode ? UColors.gray800 : Colors.white,
                          borderRadius: BorderRadius.circular(USpace.space12),
                          border: Border.all(
                            color:
                                isDarkMode ? UColors.gray700 : UColors.gray200,
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
                            highlightRowOnHover: true,
                            allowFiltering: true,
                            rowsPerPage: 10,
                            allowSorting: true,
                            columnWidthMode: ColumnWidthMode.fill,
                            gridLinesVisibility: GridLinesVisibility.none,
                            isScrollbarAlwaysShown: true,
                            rowHeight: 64,
                            showHorizontalScrollbar: true,
                            source: source,
                            columns: gridColumns,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: SfDataPagerTheme(
                      data: SfDataPagerThemeData(
                        backgroundColor: UColors.white,
                      ),
                      child: SfDataPager(
                        pageCount: pageCount(
                          data.length,
                          ref.watch(rowsPerPageProvider),
                        ),
                        delegate: source,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text('Error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }

  double pageCount(int dataCount, int rowsPerPage) {
    return (dataCount / rowsPerPage).ceilToDouble();
  }

  List<GridColumn> get gridColumns {
    return [
      GridColumn(
        minimumWidth: 150,
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        columnName: TicketGridFields.ticketNumber,
        label: const Center(
          child: Text(
            'Ticket No.',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.licenseNumber,
        label: const Center(
          child: Text(
            'License No.',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.driverName,
        label: const Center(
          child: Text(
            'Driver Name',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.dateCreated,
        label: const Center(
          child: Text(
            'Date Issued',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.totalFine,
        label: const Center(
          child: Text(
            'Fina Amount',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.status,
        label: const Center(
          child: Text(
            'Status',
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 150,
        columnName: TicketGridFields.status,
        label: const Center(
          child: Text(
            'Actions',
          ),
        ),
      ),
    ];
  }
}
