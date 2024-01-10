import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/database/aggregates/enforcer_performance.dart';
import 'package:u_traffic_admin/model/analytics/enforcer_performance.dart';

final enforcerPerformanceStream = StreamProvider<List<EnforcerPerformance>>(
  (ref) => EnforcerPerformanceDatabase.instance.getEnforcerPerformanceStream(),
);
