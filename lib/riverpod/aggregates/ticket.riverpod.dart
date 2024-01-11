import 'package:u_traffic_admin/config/enums/date_range.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/daily_dart_data.dart';
import 'package:u_traffic_admin/model/date_range.dart';

final dateRangeTypeProvider = StateProvider<DateRangeType>((ref) {
  return DateRangeType.today;
});

final dateRangeProvider = StateProvider<DateRange>((ref) {
  final dateRangeType = ref.watch(dateRangeTypeProvider);

  DateTime now = DateTime.now();
  DateTime? currentStart;
  DateTime? currentEnd;
  DateTime? previousStart;
  DateTime? previousEnd;

  if (dateRangeType == DateRangeType.today) {
    currentEnd = now;
    currentStart = DateTime(now.year, now.month, now.day);
    previousEnd = currentStart;
    previousStart = previousEnd.subtract(const Duration(days: 1));
  } else if (dateRangeType == DateRangeType.week) {
    currentEnd = now;
    currentStart = currentEnd.subtract(const Duration(days: 7));
    previousEnd = currentStart;
    previousStart = previousEnd.subtract(const Duration(days: 7));
  } else if (dateRangeType == DateRangeType.month) {
    currentEnd = now;
    currentStart = currentEnd.subtract(const Duration(days: 30));
    previousEnd = currentStart;
    previousStart = previousEnd.subtract(const Duration(days: 30));
  } else if (dateRangeType == DateRangeType.year) {
    currentEnd = now;
    currentStart = currentEnd.subtract(const Duration(days: 365));
    previousEnd = currentStart;
    previousStart = previousEnd.subtract(const Duration(days: 365));
  } else {
    return DateRange();
  }

  return DateRange(
    currentStart: Timestamp.fromDate(currentStart),
    currentEnd: Timestamp.fromDate(currentEnd),
    previousStart: Timestamp.fromDate(previousStart),
    previousEnd: Timestamp.fromDate(previousEnd),
  );
});

final totalTicketsAggregate = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);

  return TicketAggregates.instance.getTotalTicketsAggregate(dateRange);
});

final ticketByStatusAggregateProvider = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getTicketByStatusAggregate(dateRange);
});

final paidVsUnpaidAggregateProvider = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getPaidVsUnpaidAggregate(dateRange);
});

final paidTicketsAggregateProvider = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getTotalTicketsAggregate(
    dateRange,
    'status',
    'paid',
  );
});

final unpaidTicketsAggregateProvider = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getTotalTicketsAggregate(
    dateRange,
    'status',
    'unpaid',
  );
});

final cancelledTicketsAggregateProvider =
    StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getTotalTicketsAggregate(
    dateRange,
    'status',
    'cancelled',
  );
});

final overdueTicketsAggregateProvider = StreamProvider<List<ChartData>>((ref) {
  final dateRange = ref.watch(dateRangeProvider);
  return TicketAggregates.instance.getTotalTicketsAggregate(
    dateRange,
    'status',
    'overdue',
  );
});

final columnRangeProvider = StateProvider<String>((ref) {
  return 'daily';
});

final ticketsColumnChartProvider = StreamProvider<List<ColumnDataChart>>((
  ref,
) {
  final columngChartRange = ref.watch(columnRangeProvider);
  final dateRange = ref.watch(dailyTicketRangeProvider);
  final month = ref.watch(monthProvider);
  final year = ref.watch(yearProvider);

  if (columngChartRange == 'daily') {
    return TicketAggregates.instance.getDailyChartDataAggregate(
      dateRange.startDate!,
      dateRange.endDate!,
    );
  } else if (columngChartRange == 'by month') {
    return TicketAggregates.instance.getMonthlyChartDataAggregate(
      month,
      year,
    );
  } else {
    return TicketAggregates.instance.getYearlyChartDataAggregate(year);
  }
});

final violationsColumnChartProvider = StreamProvider<List<ColumnDataChart>>((
  ref,
) {
  final columngChartRange = ref.watch(columnRangeProvider);
  final dateRange = ref.watch(violationDateRangePicker);
  final month = ref.watch(violationMonthProvider);
  final year = ref.watch(violationYearProvider);

  if (columngChartRange == 'daily') {
    return TicketAggregates.instance.mostIssuedViolations(
      dateRange.startDate!,
      dateRange.endDate!,
    );
  } else if (columngChartRange == 'by month') {
    return TicketAggregates.instance.getMonthViolationData(
      month,
      year,
    );
  } else {
    return TicketAggregates.instance.getYearlyViolationData(year);
  }
});

final monthProvider = StateProvider<String>((ref) {
  return 'January';
});

final yearProvider = StateProvider<String>((ref) {
  return '2023';
});

final violationMonthProvider = StateProvider<String>((ref) {
  return 'January';
});

final violationYearProvider = StateProvider<String>((ref) {
  return '2023';
});
