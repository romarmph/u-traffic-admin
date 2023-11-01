import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketStatusChip extends StatelessWidget {
  const TicketStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case "paid":
        return Chip(
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          backgroundColor: UColors.green400,
          label: Text(
            status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: UColors.white,
            ),
          ),
        );
      case "unpaid":
        return Chip(
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          backgroundColor: UColors.red400,
          label: Text(
            status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: UColors.white,
            ),
          ),
        );
      case "cancelled":
        return Chip(
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          backgroundColor: UColors.gray400,
          label: Text(
            status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: UColors.white,
            ),
          ),
        );
      case "refunded":
        return Chip(
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          backgroundColor: UColors.purple400,
          label: Text(
            status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: UColors.white,
            ),
          ),
        );
      default:
        return Chip(
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide.none,
          backgroundColor: UColors.orange400,
          label: Text(
            status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: UColors.white,
            ),
          ),
        );
    }
  }
}
