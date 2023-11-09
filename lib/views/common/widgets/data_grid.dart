import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class DataGridContainer extends ConsumerWidget {
  const DataGridContainer({
    super.key,
    required this.constraints,
    required this.source,
    required this.gridColumns,
    required this.dataCount,
  });

  final BoxConstraints constraints;
  final DataGridSource source;
  final List<GridColumn> gridColumns;
  final int dataCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight = AppBar().preferredSize.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: constraints.maxHeight - 60 - appBarHeight - 100 - 16,
          decoration: BoxDecoration(
            color: UColors.white,
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
                dataCount,
                ref.watch(rowsPerPageProvider),
              ),
              delegate: source,
            ),
          ),
        ),
      ],
    );
  }

  double pageCount(int dataCount, int rowsPerPage) {
    if (dataCount == 0) return 1;

    return (dataCount / rowsPerPage).ceilToDouble();
  }
}
