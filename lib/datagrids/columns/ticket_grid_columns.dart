import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> ticketGridColumns = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: TicketGridFields.ticketNumber,
    label: const Center(
      child: Text(
        'Ticket No.',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.licenseNumber,
    label: const Center(
      child: Text(
        'License No.',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 200,
    columnName: TicketGridFields.driverName,
    label: const Center(
      child: Text(
        'Driver Name',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.dateCreated,
    label: const Center(
      child: Text(
        'Date Issued',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.ticketDueDate,
    filterPopupMenuOptions: const FilterPopupMenuOptions(
      filterMode: FilterMode.advancedFilter,
      showColumnName: true,
      canShowSortingOptions: true,
    ),
    allowEditing: true,
    label: const Center(
      child: Text(
        'Due Date',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.totalFine,
    label: const Center(
      child: Text(
        'Fina Amount',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.status,
    label: const Center(
      child: Text(
        'Status',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  // GridColumn(
  //   allowFiltering: false,
  //   allowSorting: false,
  //   minimumWidth: 150,
  //   columnName: TicketGridFields.actions,
  //   label: const Center(
  //     child: Text(
  //       'Actions',
  //       style: TextStyle(
  //         color: UColors.gray500,
  //         fontWeight: FontWeight.w600,
  //         fontSize: 16,
  //       ),
  //     ),
  //   ),
  // ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 300,
    maximumWidth: 400,
    columnWidthMode: ColumnWidthMode.auto,
    columnName: TicketGridFields.violations,
    label: const Center(
      child: Text(
        'Violations',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: TicketGridFields.plateNumber,
    label: const Center(
      child: Text(
        'Plate Number',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: TicketGridFields.engineNumber,
    label: const Center(
      child: Text(
        'Engine Number',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: TicketGridFields.chassisNumber,
    label: const Center(
      child: Text(
        'Chassis Number',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: TicketGridFields.conductionOrFileNumber,
    label: const Center(
      child: Text(
        'Conduction Number',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: TicketGridFields.vehicleOwner,
    label: const Center(
      child: Text(
        'Vehicle Owner',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
