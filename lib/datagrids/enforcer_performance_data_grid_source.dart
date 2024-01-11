import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/enforcer_performance_grid_field.dart';
import 'package:u_traffic_admin/model/analytics/enforcer_performance.dart';

class EnforcerPerformanceDataGridSource extends DataGridSource {
  EnforcerPerformanceDataGridSource(this.data) {
    _buildRows();
  }

  final List<EnforcerPerformance> data;

  List<DataGridRow> _performanceRows = [];

  @override
  List<DataGridRow> get rows => _performanceRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            cell.value.toString(),
            style: const TextStyle(
              color: UColors.black,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _performanceRows = data.map<DataGridRow>((data) {
      return DataGridRow(
        cells: [
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.enforcerName,
            value: data.name,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalTickets,
            value: data.totalTickets,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalPaidTickets,
            value: data.totalPaidTickets,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalUnpaidTickets,
            value: data.totalUnpaidTickets,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalCancelledTickets,
            value: data.totalTicketsCancelled,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totaloverdueTickets,
            value: data.totalTicketsoverdue,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalAmountPaid,
            value: data.totalAmountPaid,
          ),
          DataGridCell(
            columnName: EnforcerPerformanceGridFields.totalAmountUnpaid,
            value: data.totalAmountUnpaid,
          ),
        ],
      );
    }).toList();
  }
}
