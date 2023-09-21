import 'package:u_traffic_admin/config/exports/exports.dart';

class AuthService {
  final ProviderRef ref;

  AuthService(this.ref);

  static final _firebaseAuth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final adminDb = ref.watch(adminDatabaseProvider);

    final admin = await adminDb.getAdminByEmail(email);

    if (admin == null) {
      throw CustomExceptions.adminNotFound;
    }

    if (admin.isDisabled) {
      throw CustomExceptions.adminDisabled;
    }

    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
