import 'package:u_traffic_admin/config/exports/exports.dart';

final paymentDatabaseProvider = Provider<PaymentDatabase>((ref) {
  return PaymentDatabase.instance;
});

final paymentStreamProvider = StreamProvider<List<PaymentDetail>>(
  (ref) {
    final database = ref.watch(paymentDatabaseProvider);
    return database.getAllPaymenDetailsAsStream();
  },
);

final getPaymentByTicketID = FutureProvider.family<PaymentDetail, String>(
  (ref, ticketNumber) {
    final database = ref.watch(paymentDatabaseProvider);
    return database.getPaymentDetailByTicketID(ticketNumber);
  },
);
