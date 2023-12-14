import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/analytics/enforcer_performance.dart';

class EnforcerPerformanceDatabase {
  const EnforcerPerformanceDatabase._();

  static const EnforcerPerformanceDatabase _instance =
      EnforcerPerformanceDatabase._();
  static EnforcerPerformanceDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _ticketsCollection = _firestore.collection('tickets');
  static final _enforcerCollection = _firestore.collection('enforcers');

  Stream<List<EnforcerPerformance>> getEnforcerPerformanceStream() async* {
    final enforcers = await _enforcerCollection.get().then(
          (snapshot) => snapshot.docs
              .map((e) => Enforcer.fromJson(e.data(), e.id))
              .toList(),
        );

    final enforcerPerformance = <EnforcerPerformance>[];

    for (final enforcer in enforcers) {
      final enforcerTickets = await _ticketsCollection
          .where('enforcerID', isEqualTo: enforcer.id)
          .get()
          .then(
            (snapshot) => snapshot.docs
                .map((e) => Ticket.fromJson(e.data(), e.id))
                .toList(),
          );

      final int totalTickets = enforcerTickets.length;
      final int totalPaidTickets = enforcerTickets
          .where((ticket) => ticket.status == TicketStatus.paid)
          .length;
      final int totalUnpaidTickets = enforcerTickets
          .where((element) => element.status == TicketStatus.unpaid)
          .length;
      final int totalCancelledTickets = enforcerTickets
          .where((element) => element.status == TicketStatus.cancelled)
          .length;
      final int totalExpiredTickets = enforcerTickets
          .where((element) => element.status == TicketStatus.expired)
          .length;
      final double totalPaidTicketAmount = enforcerTickets
          .where((element) => element.status == TicketStatus.paid)
          .fold<double>(
              0, (previousValue, element) => previousValue + element.totalFine);
      final double totalUnpaidTicketAmount = enforcerTickets
          .where((element) => element.status == TicketStatus.unpaid)
          .fold<double>(
              0, (previousValue, element) => previousValue + element.totalFine);

      final enforcerPerformanceData = EnforcerPerformance(
        id: enforcer.id!,
        name: '${enforcer.firstName} ${enforcer.lastName}',
        totalTickets: totalTickets,
        totalPaidTickets: totalPaidTickets,
        totalUnpaidTickets: totalUnpaidTickets,
        totalTicketsCancelled: totalCancelledTickets,
        totalTicketsExpired: totalExpiredTickets,
        totalAmountPaid: totalPaidTicketAmount,
        totalAmountUnpaid: totalUnpaidTicketAmount,
      );

      enforcerPerformance.add(enforcerPerformanceData);
    }

    yield enforcerPerformance;
  }
}
