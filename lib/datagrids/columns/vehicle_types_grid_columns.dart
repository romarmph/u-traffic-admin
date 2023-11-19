import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> vehicleTypeColumns = [
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.vehicleType,
    label: const Center(
      child: Text(
        'Vehicle Type',
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
    columnName: VehicleTypeGridFields.isPublic,
    label: const Center(
      child: Text(
        'Category',
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
    columnName: VehicleTypeGridFields.isHidden,
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
  GridColumn(
    minimumWidth: 150,
    columnName: VehicleTypeGridFields.dateCreated,
    label: const Center(
      child: Text(
        'Date Created',
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
    columnName: VehicleTypeGridFields.dateEdited,
    label: const Center(
      child: Text(
        'Date Edited',
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
    allowFiltering: false,
    allowSorting: false,
    columnName: VehicleTypeGridFields.actions,
    label: const Center(
      child: Text(
        'Actions',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
