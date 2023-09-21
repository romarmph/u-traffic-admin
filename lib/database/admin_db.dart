import 'package:u_traffic_admin/config/exports/exports.dart';

class AdminDatabase {
  AdminDatabase._();

  static final AdminDatabase _instance = AdminDatabase._();
  static AdminDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Future<Admin?> getAdminByEmail(String email) async {
    const String collection = "admins";
    const String field = "email";

    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection(collection)
        .where(field, isEqualTo: email)
        .get();

    if (result.docs.isEmpty) {
      return null;
    }

    Admin admin = Admin.fromJson(
      result.docs.first.data(),
      result.docs.first.id,
    );

    return admin;
  }

  Future<Admin?> getAdminByID(String id) async {
    const String collection = "admins";

    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firestore.collection(collection).doc(id).get();

    if (!result.exists) {
      return null;
    }

    Admin admin = Admin.fromJson(
      result.data()!,
      result.id,
    );

    return admin;
  }

  Future<void> addAdmin(Admin admin) async {
    const String collection = "admins";

    await _firestore.collection(collection).add(admin.toJson());
  }

  Future<void> updateAdmin(Admin admin) async {
    const String collection = "admins";

    await _firestore
        .collection(collection)
        .doc(admin.id)
        .update(admin.toJson());
  }

  Future<void> deleteAdmin(String id) async {
    const String collection = "admins";

    await _firestore.collection(collection).doc(id).delete();
  }
}
