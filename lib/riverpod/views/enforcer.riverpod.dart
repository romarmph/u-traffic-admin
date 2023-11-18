import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerStatusQueryProvider = StateProvider<String>((ref) {
  return 'all';
});

final enforcerSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final profilePhotoStateProvider = StateProvider<MediaInfo?>((ref) {
  return null;
});
