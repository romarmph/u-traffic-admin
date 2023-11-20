import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerDatabase {
  const EnforcerDatabase._();

  static const EnforcerDatabase _instance = EnforcerDatabase._();
  static EnforcerDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _enforcerRef = _firestore.collection('enforcers');

  Stream<List<Enforcer>> getAllEnforcers() {
    try {
      return _enforcerRef.orderBy('employeeNumber').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Enforcer.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<Enforcer> getEnforcerById(String id) {
    try {
      return _enforcerRef.doc(id).snapshots().map((snapshot) {
        return Enforcer.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEnforcer(Enforcer enforcer, String uid) async {
    try {
      await _enforcerRef.doc(uid).set(enforcer.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEnforcer(Enforcer enforcer) async {
    try {
      await _enforcerRef.doc(enforcer.id).update(enforcer.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEnforcer(String id) async {
    try {
      await _enforcerRef.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Enforcer>> getAllAvailableEnforcers() async* {
    try {
      var schedules = await _firestore.collection('enforcerSchedules').get();

      var assignedEnforcerIds =
          schedules.docs.map((doc) => doc['enforcerId']).toList();

      var enforcerStream = _enforcerRef
          .where('status', whereNotIn: [
            EmployeeStatus.suspended.name,
            EmployeeStatus.terminated.name,
            EmployeeStatus.resigned.name,
          ])
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return Enforcer.fromJson(
                doc.data(),
                doc.id,
              );
            }).toList();
          });

      await for (var enforcers in enforcerStream) {
        var availableEnforcers = enforcers
            .where((enforcer) => !assignedEnforcerIds.contains(enforcer.id))
            .toList();
        yield availableEnforcers;
      }
    } catch (e) {
      rethrow;
    }
  }
}
