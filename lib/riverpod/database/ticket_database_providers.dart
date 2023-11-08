import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllTicketsStreamProvider = StreamProvider<List<Ticket>>((ref) {
  return TicketDatabase.instance.getAllTicketsAsStream();
});

final getTicketCountProvider = FutureProvider<int>((ref) async {
  return await TicketDatabase.instance.getAllTicketCount();
});

final getAllTicketByStatusStream = StreamProvider<List<Ticket>>((ref) {
  final status = ref.watch(statusQueryProvider);
  return TicketDatabase.instance.getTicketsByStatus(status);
});

final getTicketByIdFutureProvider = FutureProvider.family<Ticket, String>(
  (ref, id) {
    return TicketDatabase.instance.getTicketById(id);
  },
);

final statusQueryProvider = StateProvider<String>((ref) {
  return 'unpaid';
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final searchFieldController = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
