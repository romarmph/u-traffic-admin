import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});

final getAllUnpaidTicketsStreamProvider =
    StreamProvider.family<List<Ticket>, String>((ref, status) {
  return TicketDatabase.instance.getTicketsByStatus(status);
});

final getAllPaidTicketsStreamProvider =
    StreamProvider.family<List<Ticket>, String>((ref, status) {
  return TicketDatabase.instance.getTicketsByStatus(status);
});

final getTicketByIdFutureProvider = FutureProvider.family<Ticket, String>(
  (ref, id) {
    return TicketDatabase.instance.getTicketById(id);
  },
);
