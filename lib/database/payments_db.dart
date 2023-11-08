import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/payment_model.dart';

class PaymentDatabase {
  const PaymentDatabase._();

  static const PaymentDatabase _instance = PaymentDatabase._();
  static PaymentDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  Future<void> payTicket({
    required Ticket ticket,
    required double amountTendered,
    required double change,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final payment = PaymentDetail(
      ticketNumber: ticket.ticketNumber!,
      tenderedAmount: amountTendered,
      change: change,
      processedAt: Timestamp.now(),
      processedBy: currentUser!.uid,
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
}
