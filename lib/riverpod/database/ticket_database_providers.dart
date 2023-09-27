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

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getTicketCount();
});

final fetchedTicketCountProvider = Provider<dynamic>((ref) {
  return ref.watch(getTicketCountProvider).when(
        data: (count) => count,
        error: (error, stackTrace) => 0,
        loading: () => 0,
      );
});