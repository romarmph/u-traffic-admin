import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getAllTicketsProvider = Provider<List<Ticket>>((ref) {
  return ref.watch(getAllTicketsStreamProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});
