import 'package:u_traffic_admin/config/exports/exports.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStreamProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).user;
});
