import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});

final fetchedTicketCountProvider = Provider<dynamic>((ref) {
  return ref.watch(getTicketCountProvider).when(
        data: (count) => count,
        error: (error, stackTrace) => 0,
        loading: () => 0,
      );
});
