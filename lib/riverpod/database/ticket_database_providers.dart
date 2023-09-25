import 'package:u_traffic_admin/config/exports/exports.dart';

final getTicketProvider = FutureProvider<List<Ticket>>((ref) async {
  return await TicketDatabase.instance.getTickets();
});

final fetchedTicketsProvider = Provider<List<Ticket>>((ref) {
  return ref.watch(getTicketProvider).when(
        data: (tickets) => tickets,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
