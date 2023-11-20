import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerProviderById = StreamProvider.family<Enforcer, String>((ref, id) {
  return EnforcerDatabase.instance.getEnforcerById(id);
});

final selectedEnforcerProvider = StateProvider<Enforcer?>((ref) {
  return null;
});
final selectedTrafficPostProvider = StateProvider<TrafficPost?>((ref) {
  return null;
});

final selectedShiftProvider = StateProvider<String>((ref) {
  return 'morning';
});

final unassignedEnforcerSearchProvider = StateProvider<String>((ref) {
  return '';
});
final unassignedTrafficPostSearchProvider = StateProvider<String>((ref) {
  return '';
});
