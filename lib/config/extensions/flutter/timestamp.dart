import 'package:u_traffic_admin/config/exports/exports.dart';

extension TimestampExtension on Timestamp {
  String get toAmericanDate {
    return DateFormat('MMM dd,yyyy').format(toDate());
  }

  String get toISO8601 {
    return DateFormat('yyyy-MM-dd').format(toDate());
  }
}
