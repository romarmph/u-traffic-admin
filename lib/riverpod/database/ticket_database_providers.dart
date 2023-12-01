import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});

final getAllTicketsForTicketPage = StreamProvider<List<Ticket>>((ref) {
  final status = ref.watch(ticketViewStatusQueryProvider);
  if (status == 'all') {
    return TicketDatabase.instance.getAllTicketsAsStream();
  }
  return TicketDatabase.instance.getTicketsByStatus(status);
});

final getAllTicketsForPaymentPage = StreamProvider<List<Ticket>>((ref) {
  final status = ref.watch(paymentStatusQueryProvider);

  return TicketDatabase.instance.getTicketsByStatus(status);
});

final getTicketByIdFutureProvider = FutureProvider.family<Ticket, String>(
  (ref, id) {
    return TicketDatabase.instance.getTicketById(id);
  },
);

final getTicketByTicketNumberFutureProvider =
    FutureProvider.family<Ticket, int>((ref, ticketNumber) {
  return TicketDatabase.instance.getTicketByTicketNumber(ticketNumber);
});

final relatedTicketsStreamProvider =
    StreamProvider.family<List<Ticket>, Ticket>(
  (ref, ticket) {
    return TicketDatabase.instance.getRelatedTicketsStream(ticket);
  },
);
