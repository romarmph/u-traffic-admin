import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDatabase {
  TicketDatabase._();

  static final TicketDatabase _instance = TicketDatabase._();
  static TicketDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Future<List<Ticket>> getTickets() async {
    try {
      const String collection = "tickets";

      final QuerySnapshot<Map<String, dynamic>> result =
          await _firestore.collection(collection).get();

      if (result.docs.isEmpty) {
        return [];
      }

      List<Ticket> tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data(),
          e.id,
        );
      }).toList();
      return tickets;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
