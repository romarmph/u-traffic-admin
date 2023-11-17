import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerProviderById = StreamProvider.family<Enforcer, String>((ref, id) {
  return EnforcerDatabase.instance.getEnforcerById(id);
});
