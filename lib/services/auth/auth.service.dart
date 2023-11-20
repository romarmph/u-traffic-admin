import 'package:u_traffic_admin/config/exports/exports.dart';

class AuthService {
  AuthService();

  static final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final adminDb = AdminDatabase.instance;

    final admin = await adminDb.getAdminByEmail(email);

    if (admin == null) {
      throw CustomExceptions.adminNotFound;
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

  Future<bool> isEmailAvailable(String email) async {
    try {
      List<String> userSignInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return userSignInMethods.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> testPassword(String password, String email) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      if (e.toString().contains('wrong-password')) {
        throw CustomExceptions.incorrectPassword;
      }
    }
  }

  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      print('Password has been changed');
    } else {
      print('No user is signed in');
    }
  }
}
