import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleTypesTab extends ConsumerStatefulWidget {
  const VehicleTypesTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VehicleTypesTabState();
}

class _VehicleTypesTabState extends ConsumerState<VehicleTypesTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
