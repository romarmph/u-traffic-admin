import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> vehicleTypeColumns = [
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.vehicleType,
    label: const Center(
      child: Text(
        'Vehicle Type',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.isPublic,
    label: const Center(
      child: Text(
        'Category',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.isHidden,
    label: const Center(
      child: Text(
        'Status',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.dateCreated,
    label: const Center(
      child: Text(
        'Date Created',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.dateEdited,
    label: const Center(
      child: Text(
        'Date Edited',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    allowFiltering: false,
    allowSorting: false,
    columnName: VehicleTypeGridFields.actions,
    label: const Center(
      child: Text(
        'Actions',
      ),
    ),
  ),
];
