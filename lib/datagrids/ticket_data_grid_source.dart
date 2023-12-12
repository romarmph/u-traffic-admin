import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
// import 'package:u_traffic_admin/views/ticket/compare_ticket_page.dart';

class TicketDataGridSource extends DataGridSource {
  TicketDataGridSource({
    required this.ticketList,
    required this.currentRoute,
    required this.ref,
  }) {
    buildDataGridRows();
  }

  WidgetRef ref;
  String currentRoute;
  List<Ticket> ticketList = [];

  List<DataGridRow> _ticketRows = [];

  bool _isUnpaid = false;

  @override
  List<DataGridRow> get rows => _ticketRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        bool isUnpaid = false;

        if (dataGridCell.columnName == TicketGridFields.status) {
          _isUnpaid = dataGridCell.value.toString().toLowerCase() ==
              TicketStatus.unpaid.toString().split('.').last.toLowerCase();
        }

        if (dataGridCell.columnName == TicketGridFields.actions) {
          isUnpaid = _isUnpaid;
          _isUnpaid = false;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !isUnpaid,
                maintainSize: false,
                child: _renderViewButton(dataGridCell.value),
              ),
              Visibility(
                maintainSize: false,
                visible: isUnpaid,
                child: _renderPayButton(dataGridCell.value),
              )
            ],
          );
        }

        if (dataGridCell.columnName == TicketGridFields.status) {
          return TicketStatusChip(
            status: dataGridCell.value,
          );
        }

        if (dataGridCell.columnName == TicketGridFields.ticketNumber ||
            dataGridCell.columnName == TicketGridFields.totalFine) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              dataGridCell.value.toString().isEmpty
                  ? '-'
                  : dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const UTextStyle().textbasefontsemibold,
            ),
          );
        }

        if (dataGridCell.columnName == TicketGridFields.dateCreated ||
            dataGridCell.columnName == TicketGridFields.ticketDueDate) {
          final date = dataGridCell.value as DateTime;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              date.toTimestamp.toAmericanDate,
              overflow: TextOverflow.ellipsis,
              style: const UTextStyle().textbasefontsemibold,
            ),
          );
        }

        if (dataGridCell.columnName == TicketGridFields.violations) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dataGridCell.value,
              overflow: TextOverflow.clip,
              style: const UTextStyle().textbasefontsemibold,
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString().isEmpty
                ? '-'
                : dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const UTextStyle().textbasefontsemibold,
          ),
        );
      },
    ).toList());
  }

  void buildDataGridRows() {
    _ticketRows = ticketList
        .map<DataGridRow>((ticket) => DataGridRow(
              cells: [
                DataGridCell<int>(
                  columnName: TicketGridFields.ticketNumber,
                  value: ticket.ticketNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.licenseNumber,
                  value: ticket.licenseNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.driverName,
                  value: ticket.driverName,
                ),
                DataGridCell<DateTime>(
                  columnName: TicketGridFields.dateCreated,
                  value: ticket.dateCreated.toDate(),
                ),
                DataGridCell<DateTime>(
                  columnName: TicketGridFields.ticketDueDate,
                  value: ticket.ticketDueDate.toDate(),
                ),
                DataGridCell<double>(
                  columnName: TicketGridFields.totalFine,
                  value: ticket.totalFine,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.status,
                  value: ticket.status.toString().split('.').last.capitalize,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.violations,
                  value: ticket.issuedViolations
                      .map((e) => e.violation)
                      .toList()
                      .join(', '),
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.plateNumber,
                  value: ticket.plateNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.chassisNumber,
                  value: ticket.chassisNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.engineNumber,
                  value: ticket.engineNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.conductionOrFileNumber,
                  value: ticket.conductionOrFileNumber,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.vehicleOwner,
                  value: ticket.vehicleOwner,
                ),
              ],
            ))
        .toList();
  }

  Widget _renderViewButton(String id) {
    return OutlinedButton(
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
        goToTicketView(id, Routes.tickets);
      },
      child: const Text('View'),
    );
  }

  Widget _renderPayButton(String id) {
    return ElevatedButton(
      style: FilledButton.styleFrom(
        backgroundColor: UColors.green400,
        foregroundColor: UColors.white,
        padding: const EdgeInsets.symmetric(
          vertical: USpace.space8,
          horizontal: USpace.space16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(USpace.space8),
        ),
      ),
      onPressed: () {
        goToTicketView(id, currentRoute);
      },
      child: const Text('Pay'),
    );
  }
}
