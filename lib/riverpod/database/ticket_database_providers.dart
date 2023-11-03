import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});

final getAllUnpaidTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllUnpaidTickets();
});

final getTicketByIdFutureProvider = FutureProvider.family<Ticket, String>(
  (ref, id) {
    return TicketDatabase.instance.getTicketById(id);
  },
);
