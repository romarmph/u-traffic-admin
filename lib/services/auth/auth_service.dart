import 'package:u_traffic_admin/config/exports/exports.dart';

class AuthService {
  final ProviderRef ref;

  AuthService(this.ref);

  static final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final adminDb = ref.watch(adminDatabaseProvider);

    final admin = await adminDb.getAdminByEmail(email);

    if (admin == null) {
      throw CustomExceptions.adminNotFound;
    }

    if (admin.status == EmployeeStatus.suspended) {
      throw CustomExceptions.adminDisabled;
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      if (e.toString().contains('user-not-found')) {
        throw CustomExceptions.adminNotFound;
      }

      if (e.toString().contains('wrong-password')) {
        throw CustomExceptions.incorrectPassword;
      }

      if (e.toString().contains('too-many-requests')) {
        throw CustomExceptions.tooManyRequests;
      }
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
