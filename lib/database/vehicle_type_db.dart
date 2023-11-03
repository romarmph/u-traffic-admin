import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleTypeDatabase {
  const VehicleTypeDatabase._();

  static const VehicleTypeDatabase _instance = VehicleTypeDatabase._();

  static VehicleTypeDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Stream<List<VehicleType>> getAllVehicleTypesAsStream() {
    const String collection = "vehicleTypes";

    return _firestore
        .collection(collection)
        .orderBy('typeName')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((e) {
        return VehicleType.fromJson(
          e.data(),
          e.id,
        );
      }).toList();
    });
  }

  Future<VehicleType> getVehicleTypeById(String id) async {
    try {
      const String collection = "vehicleTypes";

      final snapshot = await _firestore.collection(collection).doc(id).get();

      if (snapshot.exists) {
        return VehicleType.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      }

      throw Exception("Vehicle Type not found");
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
