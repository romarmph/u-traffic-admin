import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/constants/payment_grid_fields.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDataGridSource extends DataGridSource {
  PaymentDataGridSource({
    required this.paymentList,
    required this.currentRoute,
    required this.ref,
  }) {
    buildDataGridRows();
  }
  WidgetRef ref;
  String currentRoute;
  List<PaymentDetail> paymentList = [];

  List<DataGridRow> _paymentRows = [];

  @override
  List<DataGridRow> get rows => _paymentRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == PaymentGridFields.datePaid) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().formattedDate,
            ),
          );
        }

        if (cell.columnName == PaymentGridFields.actions) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: USpace.space8,
                  horizontal: USpace.space16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space8),
                ),
                side: const BorderSide(color: UColors.blue600),
              ),
              onPressed: () {
                goToTicketView(cell.value, Routes.payment);
              },
              child: const Text('View Ticket'),
            ),
          );
        }

        if (cell.columnName == PaymentGridFields.processedByName) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().capitalize,
            ),
          );
        }

        if (cell.columnName == PaymentGridFields.datePaid) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            cell.value.toString().isEmpty ? '-' : cell.value.toString(),
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
            columnName: PaymentGridFields.processedByName,
            value: payment.processedByName,
          ),
          DataGridCell<DateTime>(
            columnName: PaymentGridFields.datePaid,
            value: payment.processedAt.toDate(),
          ),
          DataGridCell<String>(
            columnName: PaymentGridFields.actions,
            value: payment.ticketID,
          ),
        ],
      );
    }).toList();
  }
}
