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

  String get initial => split('').first.toUpperCase();

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

  EmployeeStatus get toEmployeeStatus {
    switch (this) {
      case 'active':
        return EmployeeStatus.active;
      case 'onduty':
        return EmployeeStatus.onduty;
      case 'onleave':
        return EmployeeStatus.onleave;
      case 'suspended':
        return EmployeeStatus.suspended;
      case 'terminated':
        return EmployeeStatus.terminated;
      default:
        return EmployeeStatus.active;
    }
  }
}
