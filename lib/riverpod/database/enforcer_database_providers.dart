import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerDatabaseProvider = Provider<EnforcerDatabase>((ref) {
  return EnforcerDatabase.instance;
});

final getAllEnforcerStream = StreamProvider<List<Enforcer>>((ref) {
  return ref.watch(enforcerDatabaseProvider).getAllEnforcers();
});

final enforcerProvider = Provider<List<Enforcer>>((ref) {
  return ref.watch(getAllEnforcerStream).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});

final getEnforcerById = StreamProvider.family<Enforcer, String>((ref, id) {
  return ref.watch(enforcerDatabaseProvider).getEnforcerById(id);
});
