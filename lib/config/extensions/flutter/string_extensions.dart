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

  int get month {
    switch (capitalize) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return 1;
    }
  }

  String get parseMonth {
    int month = int.parse(split('-').last);
    int year = int.parse(split('-').first);

    switch (month) {
      case 1:
        return '$year-January';
      case 2:
        return '$year-February';
      case 3:
        return '$year-March';
      case 4:
        return '$year-April';
      case 5:
        return '$year-May';
      case 6:
        return '$year-June';
      case 7:
        return '$year-July';
      case 8:
        return '$year-August';
      case 9:
        return '$year-September';
      case 10:
        return '$year-October';
      case 11:
        return '$year-November';
      case 12:
        return '$year-December';

      default:
        return '$year-January';
    }
  }
}
