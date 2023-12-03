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
        .orderBy('ticketNumber', descending: true)
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

  Stream<List<Ticket>> getTicketsByStatus(String query) {
    try {
      const String collection = "tickets";
      const String queryField = "status";

      return _firestore
          .collection(collection)
          .where(queryField, isEqualTo: query)
          .orderBy('ticketNumber', descending: true)
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

  Future<Ticket> getTicketByTicketNumber(int ticketNumber) async {
    try {
      const String collection = "tickets";
      const String queryField = "ticketNumber";

      final result = await _firestore
          .collection(collection)
          .where(queryField, isEqualTo: ticketNumber)
          .get();

      return Ticket.fromJson(
        result.docs.first.data(),
        result.docs.first.id,
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

  Future<void> updateTicketStatus({
    required String id,
    required TicketStatus status,
  }) async {
    try {
      const String collection = "tickets";
      final currentAdmin = AuthService().currentUser;

      await _firestore.collection(collection).doc(id).update({
        'status': status.toString().split('.').last,
        'cancelledAt': Timestamp.now(),
        'cancelledBy': currentAdmin!.uid,
      });
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Ticket>> getRelatedTicketsStream(Ticket ticket) async* {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('tickets');

    List<Ticket> allTickets = [];

    if (ticket.licenseNumber!.isNotEmpty) {
      final result = await collection
          .where(
            'licenseNumber',
            isEqualTo: ticket.licenseNumber,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    if (ticket.plateNumber!.isNotEmpty) {
      final result = await collection
          .where(
            'plateNumber',
            isEqualTo: ticket.plateNumber,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    if (ticket.engineNumber!.isNotEmpty) {
      final result = await collection
          .where(
            'engineNumber',
            isEqualTo: ticket.engineNumber,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    if (ticket.chassisNumber!.isNotEmpty) {
      final result = await collection
          .where(
            'chassisNumber',
            isEqualTo: ticket.chassisNumber,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    if (ticket.conductionOrFileNumber!.isNotEmpty) {
      final result = await collection
          .where(
            'conductionOrFileNumber',
            isEqualTo: ticket.conductionOrFileNumber,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    if (ticket.driverName!.isNotEmpty) {
      final result = await collection
          .where(
            'driverName',
            isEqualTo: ticket.driverName,
          )
          .get();
      var tickets = result.docs.map((e) {
        return Ticket.fromJson(
          e.data() as Map<String, dynamic>,
          e.id,
        );
      }).toList();
      allTickets.addAll(tickets);
    }

    yield allTickets;
  }

  Stream<List<Ticket>> getAllTodayTicket() {
    const String collection = "tickets";
    const String queryField = "dateCreated";

    final today = DateTime.now();
    final startTime = DateTime(today.year, today.month, today.day);
    final endTime = DateTime(today.year, today.month, today.day + 1);

    return _firestore
        .collection(collection)
        .where(
          queryField,
          isGreaterThanOrEqualTo: Timestamp.fromDate(startTime),
        )
        .where(
          queryField,
          isLessThanOrEqualTo: Timestamp.fromDate(endTime),
        )
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
}
