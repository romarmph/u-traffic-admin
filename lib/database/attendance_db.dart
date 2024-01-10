import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/attendance.dart';

class AttendanceDatabase {
  const AttendanceDatabase._();

  static const AttendanceDatabase _instance = AttendanceDatabase._();
  static AttendanceDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _attendanceCollection = _firestore.collection("attendance");

  Stream<List<Attendance>> getAllAttendanceStream(Timestamp date) {
    return _attendanceCollection
        .orderBy("timeIn", descending: true)
        .where("timeIn", isGreaterThanOrEqualTo: date)
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
