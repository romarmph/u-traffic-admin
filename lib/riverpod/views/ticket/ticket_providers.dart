import 'package:u_traffic_admin/config/exports/exports.dart';

final rowsPerPageProvider = StateProvider<int>((ref) {
  return 10;
});

final gridSearchProvider = StateProvider<String>((ref) {
  return '';
});

final ticketViewStatusQueryProvider = StateProvider<String>((ref) {
  return 'unpaid';
});

final ticketViewSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});
