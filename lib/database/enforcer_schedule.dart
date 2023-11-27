import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerScheduleDatabse {
  const EnforcerScheduleDatabse._();

  static const EnforcerScheduleDatabse _instance = EnforcerScheduleDatabse._();
  static EnforcerScheduleDatabse get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _enforcerSchedRef = _firestore.collection('enforcerSchedules');

  Stream<List<EnforcerSchedule>> getAllEnforcerSched() {
    try {
      return _enforcerSchedRef
          .snapshots(
        includeMetadataChanges: true,
      )
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return EnforcerSchedule.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<EnforcerSchedule>> getAllUnassignedSchedules() {
    try {
      return _enforcerSchedRef
          .where(
            'enforcerId',
            isEqualTo: '',
          )
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return EnforcerSchedule.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<EnforcerSchedule> getEnforcerSchedById(String id) {
    try {
      return _enforcerSchedRef.doc(id).snapshots().map((snapshot) {
        return EnforcerSchedule.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEnforcerSched(EnforcerSchedule enforcerSched) async {
    try {
      await _enforcerSchedRef.add(enforcerSched.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEnforcerSched(EnforcerSchedule enforcerSched) async {
    try {
      await _enforcerSchedRef
          .doc(enforcerSched.id)
          .update(enforcerSched.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEnforcerSched(String id) async {
    try {
      await _enforcerSchedRef.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setEnforcerToSchedule({
    required String enforcerId,
    required String scheduleId,
    required String adminId,
    required String enforcerName,
  }) async {
    try {
      await _enforcerSchedRef.doc(scheduleId).update({
        'enforcerId': enforcerId,
        'enforcerName': enforcerName,
        'updatedBy': adminId,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
