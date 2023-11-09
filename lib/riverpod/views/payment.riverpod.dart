import 'package:u_traffic_admin/config/exports/exports.dart';

final paymentSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final paymentStatusQueryProvider = StateProvider<String>((ref) {
  return 'unpaid';
});
