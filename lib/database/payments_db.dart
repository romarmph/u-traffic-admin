import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDatabase {
  const PaymentDatabase._();

  static const PaymentDatabase _instance = PaymentDatabase._();
  static PaymentDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Future<void> payTicket({
    required Ticket ticket,
    required double amountTendered,
    required double change,
    required String cashierName,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final payment = PaymentDetail(
      ticketNumber: ticket.ticketNumber!,
      ticketID: ticket.id!,
      tenderedAmount: amountTendered,
      change: change,
      processedAt: Timestamp.now(),
      processedBy: currentUser!.uid,
      processedByName: cashierName,
      method: PaymentMethod.cash,
      fineAmount: ticket.totalFine,
    );

    try {
      await _firestore.collection('payments').add(
            payment.toJson(),
          );
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PaymentDetail>> getAllPaymenDetailsAsStream() {
    try {
      return _firestore
          .collection('payments')
          .orderBy('processedAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return PaymentDetail.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentDetail> getPaymentDetailByTicketID(String ticketID) async {
    try {
      final snapshot = await _firestore
          .collection('payments')
          .where('ticketID', isEqualTo: ticketID)
          .get();

      return PaymentDetail.fromJson(
        snapshot.docs.first.data(),
        snapshot.docs.first.id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
