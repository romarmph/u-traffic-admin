import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerShiftQuertProvider = StateProvider<String>((ref) {
  return 'all';
});

final enforcerSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});
