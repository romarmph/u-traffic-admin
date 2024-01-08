import 'package:u_traffic_admin/config/exports/exports.dart';

extension DateTimeExtension on DateTime {
  Timestamp get toTimestamp {
    return Timestamp.fromDate(this);
  }

  String get toMonthYear {
    return DateFormat('MMMM yyyy').format(this);
  }
}
