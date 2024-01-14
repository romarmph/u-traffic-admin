import 'package:u_traffic_admin/config/exports/exports.dart';

class Attendance {
  final String? id;
  final EnforcerSchedule schedule;
  final Timestamp timeIn;
  final Timestamp? timeOut;

  Attendance({
    this.id,
    required this.schedule,
    required this.timeIn,
    required this.timeOut,
  });

  Attendance copyWith({
    String? id,
    EnforcerSchedule? schedule,
    Timestamp? timeIn,
    Timestamp? timeOut,
  }) {
    return Attendance(
      id: id ?? this.id,
      schedule: schedule ?? this.schedule,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'schedule': schedule.toJson(),
      'timeIn': timeIn,
      'timeOut': timeOut,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map, String id) {
    return Attendance(
      id: id,
      schedule: EnforcerSchedule.fromJson(
        map['schedule'],
        map['schedule']['id'],
      ),
      timeIn: map['timeIn'],
      timeOut: map['timeOut'],
    );
  }
}
