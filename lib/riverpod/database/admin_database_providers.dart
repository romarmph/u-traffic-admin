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

final getAllAdminStream = StreamProvider<List<Admin>>(
  (ref) {
    final adminDatabase = ref.watch(adminDatabaseProvider);
    return adminDatabase.getAllAdminStream();
  },
);

final adminProvider = Provider<List<Admin>>(
  (ref) {
    return ref.watch(getAllAdminStream).when(
          data: (data) => data,
          error: (error, stackTrace) => [],
          loading: () => [],
        );
  },
);

final getAdminByIdStream = StreamProvider.family<Admin, String>(
  (ref, id) {
    final adminDatabase = ref.watch(adminDatabaseProvider);
    return adminDatabase.getAdminByIdStream(id);
  },
);
