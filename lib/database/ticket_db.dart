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

  Stream<List<Ticket>> getAllUnpaidTickets() {
    try {
      const String collection = "tickets";
      const String queryField = "status";
      const String query = "unpaid";

      return _firestore
          .collection(collection)
          .where(queryField, isEqualTo: query)
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
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Ticket> getTicketById(String id) async {
    try {
      const String collection = "tickets";

      final result = await _firestore.collection(collection).doc(id).get();

      return Ticket.fromJson(
        result.data()!,
        result.id,
      );
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
