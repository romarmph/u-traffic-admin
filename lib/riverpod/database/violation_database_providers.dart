import 'package:u_traffic_admin/config/exports/exports.dart';

final violationsStreamProvider = StreamProvider<List<Violation>>(
  (ref) => ViolationDatabase.instance.getAllViolationStream(),
);

final violationsProvider = Provider<List<Violation>>(
  (ref) => ref.watch(violationsStreamProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      ),
);

final violationByIdProvider = StreamProvider.family<Violation, String>(
  (ref, id) => ViolationDatabase.instance.getViolationByIdStream(id),
);
