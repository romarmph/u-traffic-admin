import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/attendance.dart';

class AttendanceDatabase {
  const AttendanceDatabase._();

  static const AttendanceDatabase _instance = AttendanceDatabase._();
  static AttendanceDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _attendanceCollection = _firestore.collection("attendance");

  Stream<List<Attendance>> getAllAttendanceStream() {
    return _attendanceCollection
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Attendance.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }
}
