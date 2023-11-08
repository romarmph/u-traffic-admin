import 'package:u_traffic_admin/config/exports/exports.dart';

class ViolationDatabase {
  const ViolationDatabase._();

  static const ViolationDatabase _instance = ViolationDatabase._();
  static ViolationDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Violation>> getAllViolationStream() {
    try {
      return _firestore
          .collection('violations')
          .orderBy('name')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Violation.fromJson(doc.data(), doc.id);
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}
