import 'package:u_traffic_admin/config/exports/exports.dart';

final adminDatabaseProvider = Provider<AdminDatabase>((ref) {
  return AdminDatabase.instance;
});

final getAdminByIdFutureProvider = FutureProvider.family<Admin, String>(
  (ref, id) async {
    final adminDatabase = ref.watch(adminDatabaseProvider);
    return adminDatabase.getAdminById(id);
  },
);

final adminByIdProvider = Provider.family<Admin, String>((ref, id) {
  return ref.watch(getAdminByIdFutureProvider(id)).asData!.value;
});
