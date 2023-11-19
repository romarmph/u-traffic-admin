import 'package:u_traffic_admin/config/enums/shift_period.dart';

class TimePeriod {
  final int hour;
  final int minute;
  final String period;

  TimePeriod({
    required this.hour,
    this.minute = 0,
    required this.period,
  });

  factory TimePeriod.fromJson(Map<String, dynamic> json) {
    return TimePeriod(
      hour: json['hour'],
      minute: json['minute'],
      period: json['period'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'period': period,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimePeriod &&
        other.hour == hour &&
        other.minute == minute &&
        other.period == period;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode ^ period.hashCode;

  Duration timeDifference(TimePeriod endTime) {
    DateTime dt1 = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, period == 'AM' ? hour : hour + 12, minute);
    DateTime dt2 = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        endTime.period == 'AM' ? endTime.hour : endTime.hour + 12,
        endTime.minute);

    Duration difference = dt2.difference(dt1);

    return difference;
  }

  ShiftPeriod getShiftPeriod(TimePeriod endTime) {
    // Convert TimePeriods to DateTime
    DateTime dt1 = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, period == 'AM' ? hour : hour + 12, minute);
    DateTime dt2 = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        endTime.period == 'AM' ? endTime.hour : endTime.hour + 12,
        endTime.minute);

    // Calculate difference in hours
    int difference = dt2.difference(dt1).inHours;

    // Determine shift period based on difference
    if (difference >= 5 && difference < 13) {
      return ShiftPeriod.morning;
    } else if (difference >= 13 && difference < 21) {
      return ShiftPeriod.afternoon;
    } else {
      return ShiftPeriod.night;
    }
  }
}
