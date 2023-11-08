import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/constants/payment_grid_fields.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDataGridSource extends DataGridSource {
  PaymentDataGridSource({
    required this.paymentList,
    required this.currentRoute,
  }) {
    buildDataGridRows();
  }

  String currentRoute;
  List<PaymentDetail> paymentList = [];

  List<DataGridRow> _paymentRows = [];

  @override
  List<DataGridRow> get rows => _paymentRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString().isEmpty
                ? '-'
                : dataGridCell.value.toString(),
          ),
        );
      }).toList(),
    );
  }

  void buildDataGridRows() {
    _paymentRows = paymentList.map<DataGridRow>((payment) {
      return DataGridRow(
        cells: [
          DataGridCell<int>(
            columnName: PaymentGridFields.ticketNumber,
            value: payment.ticketNumber,
          ),
          DataGridCell<double>(
            columnName: PaymentGridFields.fineAmount,
            value: payment.fineAmount,
          ),
          DataGridCell<double>(
            columnName: PaymentGridFields.tenderedAmount,
            value: payment.tenderedAmount,
          ),
          DataGridCell<double>(
            columnName: PaymentGridFields.change,
            value: payment.change,
          ),
          DataGridCell<String>(
            columnName: PaymentGridFields.processedBy,
            value: payment.processedBy,
          ),
          DataGridCell<DateTime>(
            columnName: PaymentGridFields.datePaid,
            value: payment.processedAt.toDate(),
          ),
        ],
      );
    }).toList();
  }
}
