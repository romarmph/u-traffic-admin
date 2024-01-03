import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/database/attendance_db.dart';
import 'package:u_traffic_admin/model/attendance.dart';

final attendanceProvider = StreamProvider.autoDispose<List<Attendance>>(
  (ref) {
    return AttendanceDatabase.instance.getAllAttendanceStream();
  },
);
