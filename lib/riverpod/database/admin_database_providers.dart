import 'package:u_traffic_admin/config/exports/exports.dart';

final adminDatabaseProvider = Provider<AdminDatabase>((ref) {
  return AdminDatabase.instance;
});

final getCurrentAdmin = FutureProvider<Admin>(
  (ref) async {
    final adminDatabase = ref.watch(adminDatabaseProvider);
    final authProvider = ref.watch(authServiceProvider);
    return adminDatabase.getAdminById(authProvider.currentUser!.uid);
  },
);

final currentAdminProvider = Provider((ref) {
  return ref.watch(getCurrentAdmin).asData!.value;
});

final getAdminById = FutureProvider.family<Admin, String>(
  (ref, id) async {
    final adminDatabase = ref.watch(adminDatabaseProvider);
    return adminDatabase.getAdminById(id);
  },
);
