import 'package:u_traffic_admin/config/exports/exports.dart';

final vehicleTypesStreamProvider = StreamProvider<List<VehicleType>>(
  (ref) => VehicleTypeDatabase.instance.getAllVehicleTypesAsStream(),
);

final vehicleTypesProvider = Provider<List<VehicleType>>(
  (ref) => ref.watch(vehicleTypesStreamProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      ),
);
