import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/daily_dart_data.dart';
import 'package:u_traffic_admin/model/date_range.dart';

class TicketAggregates {
  const TicketAggregates._();

  static const TicketAggregates _instance = TicketAggregates._();
  static TicketAggregates get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection("tickets");

  Stream<List<ChartData>> getTotalTicketsAggregate(
    DateRange dateRange, [
    String? queryField,
    String? query,
  ]) async* {
    try {
      List<ChartData> aggregates = [];
      AggregateQuerySnapshot current;
      AggregateQuerySnapshot previous;

      if (dateRange.currentEnd == null) {
        if (query == null && queryField == null) {
          current = await _collection.count().get();
          previous = await _collection.count().get();
        } else {
          current = await _collection
              .where(queryField!, isEqualTo: query)
              .count()
              .get();

          previous = await _collection
              .where(queryField, isEqualTo: query)
              .count()
              .get();
        }
      } else {
        if (query == null && queryField == null) {
          current = await _collection
              .where("dateCreated",
                  isGreaterThanOrEqualTo: dateRange.currentStart)
              .where("dateCreated", isLessThanOrEqualTo: dateRange.currentEnd)
              .count()
              .get();

          previous = await _collection
              .where("dateCreated",
                  isGreaterThanOrEqualTo: dateRange.previousStart)
              .where("dateCreated", isLessThanOrEqualTo: dateRange.previousEnd)
              .count()
              .get();
        } else {
          current = await _collection
              .where(queryField!, isEqualTo: query)
              .where("dateCreated",
                  isGreaterThanOrEqualTo: dateRange.currentStart)
              .where("dateCreated", isLessThanOrEqualTo: dateRange.currentEnd)
              .count()
              .get();

          previous = await _collection
              .where(queryField, isEqualTo: query)
              .where("dateCreated",
                  isGreaterThanOrEqualTo: dateRange.previousStart)
              .where("dateCreated", isLessThanOrEqualTo: dateRange.previousEnd)
              .count()
              .get();
        }
      }

      aggregates.add(
        ChartData(
          "CURRENT",
          current.count.toDouble(),
        ),
      );

      aggregates.add(
        ChartData(
          "PREVIOUS",
          previous.count.toDouble(),
        ),
      );

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ChartData>> getTicketByStatusAggregate(
    DateRange dateRange,
  ) async* {
    try {
      const String queryField = "status";
      List<ChartData> aggregates = [];

      if (dateRange.currentStart == null) {
        for (var status in TicketStatus.values) {
          final result = await _collection
              .where(queryField, isEqualTo: status.name)
              .count()
              .get();

          aggregates.add(
            ChartData(
              status.name.toUpperCase(),
              result.count as double,
            ),
          );
        }
      } else {
        for (var status in TicketStatus.values) {
          final result = await _collection
              .where(queryField, isEqualTo: status.name)
              .where(
                'dateCreated',
                isGreaterThanOrEqualTo: dateRange.currentStart,
              )
              .count()
              .get();

          aggregates.add(
            ChartData(
              status.name.toUpperCase(),
              result.count as double,
            ),
          );
        }
      }

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ChartData>> getPaidVsUnpaidAggregate(DateRange dateRange) async* {
    try {
      const String queryField = "status";
      List<ChartData> aggregates = [];

      if (dateRange.currentStart == null) {
        for (var status in ['paid', 'unpaid']) {
          final result = await _collection
              .where(queryField, isEqualTo: status)
              .count()
              .get();

          aggregates.add(
            ChartData(
              status.toUpperCase(),
              result.count as double,
            ),
          );
        }
      } else {
        for (var status in ['paid', 'unpaid']) {
          final result = await _collection
              .where(queryField, isEqualTo: status)
              .where(
                'dateCreated',
                isGreaterThanOrEqualTo: dateRange.currentStart,
              )
              .count()
              .get();

          aggregates.add(
            ChartData(
              status.toUpperCase(),
              result.count as double,
            ),
          );
        }
      }

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ColumnDataChart>> getDailyChartDataAggregate() async* {
    try {
      final now = DateTime.now();

      List<ColumnDataChart> aggregates = [];

      for (var i = 0; i < 30; i++) {
        final startOfDay = DateTime(now.year, now.month, now.day - i);
        final endOfDay = DateTime(now.year, now.month, now.day - i, 23, 59, 59);

        final result = await _collection
            .where('dateCreated',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
            .where('dateCreated',
                isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
            .count()
            .get();

        aggregates.add(
          ColumnDataChart(
            column: startOfDay.day.toString(),
            count: result.count,
          ),
        );
      }

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ColumnDataChart>> getMonthlyChartDataAggregate() async* {
    try {
      final now = DateTime.now();

      final currentMonth = now.month;
      List<ColumnDataChart> aggregates = [];

      for (var i = 1; i <= currentMonth; i++) {
        final startOfMonth = DateTime(now.year, i, 0, 0, 0, 0, 0);
        final endOfMonth = DateTime(now.year, i + 1, 0, 0, 0, 0, 0, 0);

        final result = await _collection
            .where('dateCreated',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
            .where('dateCreated',
                isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
            .count()
            .get();

        aggregates.add(
          ColumnDataChart(
            column: DateFormat.MMMM().format(startOfMonth),
            count: result.count,
          ),
        );
      }

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ColumnDataChart>> getYearlyChartDataAggregate() async* {
    try {
      final now = DateTime.now();

      final currentYear = now.year;
      List<ColumnDataChart> aggregates = [];

      for (var i = 2019; i <= currentYear; i++) {
        final startOfYear = DateTime(i, 1, 1, 0, 0, 0);
        final endOfYear = DateTime(i + 1, 1, 1, 0, 0, 0);

        final result = await _collection
            .where('dateCreated',
                isGreaterThanOrEqualTo: Timestamp.fromDate(startOfYear))
            .where('dateCreated', isLessThan: Timestamp.fromDate(endOfYear))
            .count()
            .get();

        aggregates.add(
          ColumnDataChart(
            column: i.toString(),
            count: result.count,
          ),
        );
      }

      yield aggregates;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
