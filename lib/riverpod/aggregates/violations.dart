import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/database/aggregates/violations.dart';
import 'package:u_traffic_admin/model/analytics/violation_data.dart';

final violationsAggregate = StreamProvider<List<ViolationData>>((ref) {
  return ViolationsAggregate.instance.getViolationsByDay();
});
