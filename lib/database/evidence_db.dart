import 'package:u_traffic_admin/config/exports/exports.dart';

class EvidenceDatabase {
  const EvidenceDatabase._();

  static EvidenceDatabase get _instance => const EvidenceDatabase._();
  static EvidenceDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Evidence>> getEvidenceByTicketNumber(int ticketNumber) {
    try {
      final data = _firestore
          .collection('evidences')
          .where('ticketNumber', isEqualTo: ticketNumber)
          .snapshots();

      return data.map((event) {
        return event.docs.map((e) {
          return Evidence.fromJson(e.data(), e.id);
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}
