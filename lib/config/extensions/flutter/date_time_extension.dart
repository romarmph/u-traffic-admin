import 'package:u_traffic_admin/config/exports/exports.dart';

extension DateTimeExtension on DateTime {
  Timestamp get toTimestamp {
    return Timestamp.fromDate(this);
  }
}
