import 'package:u_traffic_admin/config/exports/exports.dart';

extension TimestampExtension on Timestamp {
  String get toAmericanDate {
    return DateFormat('MMM dd,yyyy').format(toDate());
  }

  String get toTime {
    return DateFormat('hh:mm a').format(toDate());
  }

  String get toISO8601 {
    return DateFormat('yyyy-MM-dd').format(toDate());
  }

  Timestamp get addSevenDays {
    return Timestamp.fromDate(toDate().add(const Duration(days: 7)));
  }
}
