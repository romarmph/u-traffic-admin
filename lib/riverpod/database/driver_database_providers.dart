import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/database/driver_database.dart';

final getDriverByIdProvider = StreamProvider.family<Driver, String>((ref, id) {
  return DriverDatabase.instance.getDriverById(id);
});