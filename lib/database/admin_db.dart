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

  Future<Admin> getAdminById(String id) async {
    try {
      const String collection = "admins";

      final DocumentSnapshot<Map<String, dynamic>> result =
          await _firestore.collection(collection).doc(id).get();

      Admin admin = Admin.fromJson(
        result.data()!,
        result.id,
      );

      return admin;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAdmin(Admin admin, String uid) async {
    const String collection = "admins";

    await _firestore.collection(collection).doc(uid).set(admin.toJson());
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

  Stream<List<Admin>> getAllAdminStream() {
    try {
      const String collection = "admins";

      return _firestore.collection(collection).snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              return Admin.fromJson(
                doc.data(),
                doc.id,
              );
            },
          ).toList();
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Stream<Admin> getAdminByIdStream(String id) {
    try {
      const String collection = "admins";

      return _firestore.collection(collection).doc(id).snapshots().map(
        (snapshot) {
          return Admin.fromJson(
            snapshot.data()!,
            snapshot.id,
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAdminPermission(
      String id, List<AdminPermission> permission) async {
    const String collection = "admins";

    await _firestore.collection(collection).doc(id).update({
      'permissions': permission.map((e) => e.name).toList(),
    });
  }
}
