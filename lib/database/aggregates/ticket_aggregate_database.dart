import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/date_range.dart';

class TicketAggregates {
  const TicketAggregates._();

  static const TicketAggregates _instance = TicketAggregates._();
  static TicketAggregates get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection("tickets");

  Stream<List<ChartData>> getTotalTicketsAggregate(
    DateRange dateRange,
  ) async* {
    try {
      const String queryField = "dateCreated";

      List<ChartData> aggregates = [];
      AggregateQuerySnapshot current;
      AggregateQuerySnapshot previous;

      if (dateRange.currentEnd == null) {
        current = await _collection.count().get();
        previous = await _collection.count().get();
      } else {
        current = await _collection
            .where(queryField, isGreaterThanOrEqualTo: dateRange.currentStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.currentEnd)
            .count()
            .get();

        previous = await _collection
            .where(queryField, isGreaterThanOrEqualTo: dateRange.previousStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.previousEnd)
            .count()
            .get();
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

  Stream<List<ChartData>> paidTicketsAggregate(DateRange dateRange) async* {
    try {
      const String queryField = "dateCreated";

      List<ChartData> aggregates = [];
      AggregateQuerySnapshot current;
      AggregateQuerySnapshot previous;

      if (dateRange.currentEnd == null) {
        current = await _collection.count().get();
        previous = await _collection.count().get();
      } else {
        current = await _collection
            .where('status', isEqualTo: 'paid')
            .where(queryField, isGreaterThanOrEqualTo: dateRange.currentStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.currentEnd)
            .count()
            .get();

        previous = await _collection
            .where('status', isEqualTo: 'paid')
            .where(queryField, isGreaterThanOrEqualTo: dateRange.previousStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.previousEnd)
            .count()
            .get();
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

  Stream<List<ChartData>> unpaidTicketsAggregate(DateRange dateRange) async* {
    try {
      const String queryField = "dateCreated";

      List<ChartData> aggregates = [];
      AggregateQuerySnapshot current;
      AggregateQuerySnapshot previous;

      if (dateRange.currentEnd == null) {
        current = await _collection.count().get();
        previous = await _collection.count().get();
      } else {
        current = await _collection
            .where('status', isEqualTo: 'unpaid')
            .where(queryField, isGreaterThanOrEqualTo: dateRange.currentStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.currentEnd)
            .count()
            .get();

        previous = await _collection
            .where('status', isEqualTo: 'unpaid')
            .where(queryField, isGreaterThanOrEqualTo: dateRange.previousStart)
            .where(queryField, isLessThanOrEqualTo: dateRange.previousEnd)
            .count()
            .get();
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

  
}
