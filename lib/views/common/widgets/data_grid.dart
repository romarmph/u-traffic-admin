import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class DataGridContainer extends ConsumerWidget {
  const DataGridContainer({
    super.key,
    required this.constraints,
    required this.source,
    required this.gridColumns,
    required this.dataCount,
    this.dataGridKey,
    this.gridLinesVisibility = GridLinesVisibility.horizontal,
    this.headerGridLinesVisibility = GridLinesVisibility.horizontal,
    this.height,
  });

  final BoxConstraints constraints;
  final DataGridSource source;
  final List<GridColumn> gridColumns;
  final int dataCount;
  final GlobalKey<SfDataGridState>? dataGridKey;
  final GridLinesVisibility gridLinesVisibility;
  final GridLinesVisibility headerGridLinesVisibility;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: height,
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(USpace.space16),
          ),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineColor: UColors.gray100,
              gridLineStrokeWidth: 1,
              rowHoverColor: UColors.gray100,
              headerHoverColor: UColors.gray100,
            ),
            child: SfDataGrid(
              gridLinesVisibility: gridLinesVisibility,
              key: dataGridKey,
              rowsPerPage: 12,
              highlightRowOnHover: true,
              allowFiltering: true,
              allowSorting: true,
              columnWidthMode: ColumnWidthMode.fill,
              headerGridLinesVisibility: headerGridLinesVisibility,
              source: source,
              columns: gridColumns,
              footer: dataCount == 0
                  ? const Center(child: Text('No data found'))
                  : null,
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
                12,
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
