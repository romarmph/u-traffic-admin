import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerSchedDatabaseProvider = Provider<EnforcerScheduleDatabse>((ref) {
  return EnforcerScheduleDatabse.instance;
});

final getAllEnforcerSchedStream = StreamProvider<List<EnforcerSchedule>>((ref) {
  return EnforcerScheduleDatabse.instance.getAllEnforcerSched();
});

final enforcerSchedProvider = Provider<List<EnforcerSchedule>>((ref) {
  return ref.watch(getAllEnforcerSchedStream).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});

final availableEnforcerStreamProvider = StreamProvider<List<Enforcer>>((ref) {
  return EnforcerDatabase.instance.getAllAvailableEnforcers();
});

final availableEnforcerProvider = Provider<List<Enforcer>>((ref) {
  return ref.watch(availableEnforcerStreamProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});

final enforcerSchedByIdStream =
    StreamProvider.family<EnforcerSchedule, String>((ref, id) {
  return ref.watch(enforcerSchedDatabaseProvider).getEnforcerSchedById(id);
});
