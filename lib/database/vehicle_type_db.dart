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

  Stream<VehicleType> getVehicleTypeByIdStream(String id) {
    const String collection = "vehicleTypes";

    return _firestore
        .collection(collection)
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return VehicleType.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      }

      throw Exception("Vehicle Type not found");
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

  Future<void> addVehicleType(VehicleType vehicleType) async {
    try {
      const String collection = "vehicleTypes";

      await _firestore.collection(collection).add(
            vehicleType.toJson(),
          );
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateVehicleType(VehicleType vehicleType) async {
    try {
      const String collection = "vehicleTypes";

      await _firestore.collection(collection).doc(vehicleType.id).update(
            vehicleType.toJson(),
          );
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteVehicleType(String id) async {
    try {
      const String collection = "vehicleTypes";

      await _firestore.collection(collection).doc(id).delete();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
