import 'package:u_traffic_admin/config/exports/exports.dart';

final adminSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final adminStatusQueryProvider = StateProvider<String>((ref) {
  return "all";
});

final selectedPermissionsProvider = StateProvider<List<AdminPermission>>((ref) {
  return [];
});
