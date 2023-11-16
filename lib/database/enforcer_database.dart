import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerDatabase {
  const EnforcerDatabase._();

  static const EnforcerDatabase _instance = EnforcerDatabase._();
  static EnforcerDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _enforcerRef = _firestore.collection('enforcers');

  Stream<List<Enforcer>> getAllEnforcers() {
    try {
      return _enforcerRef.snapshots().map((snapshot) {
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

  Future<void> addEnforcer(Enforcer enforcer) async {
    try {
      await _enforcerRef.add(enforcer.toJson());
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
}
