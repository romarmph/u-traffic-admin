import 'package:u_traffic_admin/config/exports/exports.dart';

class DriverDatabase {
  const DriverDatabase._();

  static const DriverDatabase _instance = DriverDatabase._();
  static DriverDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('drivers');

  Stream<List<Driver>> getDrivers() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Driver.fromJson(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Stream<Driver> getDriverById(String id) {
    return _collection.doc(id).snapshots().map((snapshot) {
      return Driver.fromJson(
        snapshot.data()!,
        snapshot.id,
      );
    });
  }
}
