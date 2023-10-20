import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDatabase {
  TicketDatabase._();

  static final TicketDatabase _instance = TicketDatabase._();
  static TicketDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Ticket>> getAllTicketsAsStream() {
    const String collection = "tickets";

    return _firestore
        .collection(collection)
        .orderBy('ticketNumber')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((e) {
        return Ticket.fromJson(
          e.data(),
          e.id,
        );
      }).toList();
    });
  }

  Future<List<Ticket>> getAllUnpaidTickets() async {
    try {
      const String collection = "tickets";
      const String queryField = "status";
      const String query = "unpaid";

      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection(collection)
          .where(queryField, isEqualTo: query)
          .get();

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
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getAllTicketCount() async {
    try {
      const String collection = "tickets";

      final result = await _firestore.collection(collection).count().get();

      return result.count;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Cancel Ticket: Must be approve by chief
}
