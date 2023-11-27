import 'package:u_traffic_admin/config/exports/exports.dart';

final databaseProvider = Provider<TrafficPostDatabase>((ref) {
  return TrafficPostDatabase.instance;
});

final getAllTrafficPostProvider = StreamProvider<List<TrafficPost>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.getAllTrafficPostStream();
});

final trafficPostProviderById =
    StreamProvider.family<TrafficPost, String>((ref, id) {
  final database = ref.watch(databaseProvider);
  return database.getTrafficPostStream(id);
});

final trafficPostProvider = Provider<List<TrafficPost>>((ref) {
  return ref.watch(getAllTrafficPostProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
