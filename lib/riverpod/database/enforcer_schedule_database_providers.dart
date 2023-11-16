import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerSchedDatabaseProvider = Provider<EnforcerScheduleDatabse>((ref) {
  return EnforcerScheduleDatabse.instance;
});

final getAllEnforcerSchedStream = StreamProvider<List<EnforcerSchedule>>((ref) {
  return ref.watch(enforcerSchedDatabaseProvider).getAllEnforcerSched();
});

final enforcerSchedProvider = Provider<List<EnforcerSchedule>>((ref) {
  return ref.watch(getAllEnforcerSchedStream).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
