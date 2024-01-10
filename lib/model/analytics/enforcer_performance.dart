class EnforcerPerformance {
  final String id;
  final String name;
  final int totalTickets;
  final int totalPaidTickets;
  final int totalUnpaidTickets;
  final int totalTicketsCancelled;
  final int totalTicketsExpired;
  final double totalAmountPaid;
  final double totalAmountUnpaid;

  EnforcerPerformance({
    required this.id,
    required this.name,
    this.totalTickets = 0,
    this.totalPaidTickets = 0,
    this.totalUnpaidTickets = 0,
    this.totalTicketsCancelled = 0,
    this.totalTicketsExpired = 0,
    this.totalAmountPaid = 0,
    this.totalAmountUnpaid = 0,
  });
}
