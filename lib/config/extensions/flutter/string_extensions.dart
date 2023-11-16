import 'package:u_traffic_admin/config/exports/exports.dart';

extension StringExtension on String {
  DateTime get toDateTime {
    return DateTime.parse(this);
  }

  String get capitalize {
    return split('').first.toUpperCase() + substring(1);
  }

  String get formattedDate => toDateTime.toTimestamp.toAmericanDate;

  String get enumValue => split('.').last;

  ShiftPeriod get toShiftPeriod {
    switch (this) {
      case 'morning':
        return ShiftPeriod.morning;
      case 'afternoon':
        return ShiftPeriod.afternoon;
      case 'night':
        return ShiftPeriod.night;
      default:
        return ShiftPeriod.morning;
    }
  }
}
