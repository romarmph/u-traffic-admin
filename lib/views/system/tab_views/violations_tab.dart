import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ViolationsTab extends ConsumerStatefulWidget {
  const ViolationsTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViolationsTabState();
}

class _ViolationsTabState extends ConsumerState<ViolationsTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
