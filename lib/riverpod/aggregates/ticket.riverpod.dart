import 'package:u_traffic_admin/config/exports/exports.dart';

final ticketByStatusAggregateProvider =
    StreamProvider<List<PieChartData>>((ref) {
  return TicketDatabase.instance.getTicketByStatusAggregate();
});
