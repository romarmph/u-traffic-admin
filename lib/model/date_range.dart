import 'package:u_traffic_admin/config/exports/exports.dart';

class DateRange {
  final Timestamp? currentStart;
  final Timestamp? currentEnd;
  final Timestamp? previousStart;
  final Timestamp? previousEnd;

  DateRange({
    this.currentStart,
    this.currentEnd,
    this.previousStart,
    this.previousEnd,
  });

  @override
  String toString() {
    return 'DateRange(currentStart: ${currentStart?.toAmericanDate}, currentEnd: ${currentEnd?.toAmericanDate}, previousStart: ${previousStart?.toAmericanDate}, previousEnd: ${previousEnd?.toAmericanDate})';
  }
}
