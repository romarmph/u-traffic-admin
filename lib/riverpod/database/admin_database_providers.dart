import 'package:u_traffic_admin/config/exports/exports.dart';

final adminDatabaseProvider = Provider<AdminDatabase>((ref) {
  return AdminDatabase.instance;
});