import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataGrid extends ConsumerWidget {
  const TicketDataGrid({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight = AppBar().preferredSize.height;
    return ref.watch(getAllTicketsStreamProvider).when(
          data: (data) {
            final TicketDataGridSource source = TicketDataGridSource(
              data,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height:
                        constraints.maxHeight - 60 - appBarHeight - 100 - 16,
                    decoration: BoxDecoration(
                      color: UColors.white,
                      // border: Border.all(
                      //   color: UColors.blue600,
                      // ),
                      borderRadius: BorderRadius.circular(USpace.space16),
                    ),
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(),
                      child: SfDataGrid(
                        rowsPerPage: 12,
                        highlightRowOnHover: true,
                        allowFiltering: true,
                        allowSorting: true,
                        columnWidthMode: ColumnWidthMode.fill,
                        source: source,
                        columns: gridColumns,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 60,
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
        columnName: TicketGridFields.dateCreated,
        label: const Center(
          child: Text(
            'Due Date',
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
