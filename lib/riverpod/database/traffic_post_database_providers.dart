import 'package:u_traffic_admin/config/exports/exports.dart';

final databaseProvider = Provider<TrafficPostDatabase>((ref) {
  return TrafficPostDatabase.instance;
});

final getAllTrafficPostProvider = StreamProvider<List<TrafficPost>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.getAllTrafficPostStream();
});
