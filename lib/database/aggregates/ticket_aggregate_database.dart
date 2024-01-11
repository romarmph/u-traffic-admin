import 'package:flutter/semantics.dart';
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

  Stream<List<ColumnDataChart>> getDailyChartDataAggregate(
      DateTime start, DateTime end) async* {
    Timestamp startTimestamp = Timestamp.fromDate(start);
    Timestamp endTimestamp = Timestamp.fromDate(end);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, int> dailyTicketCount = {};
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      String dateString =
          DateFormat('yyyy-MM-dd').format(start.add(Duration(days: i)));
      dailyTicketCount[dateString] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot querySnapshot = await tickets
        .where('dateCreated', isGreaterThanOrEqualTo: startTimestamp)
        .where('dateCreated', isLessThanOrEqualTo: endTimestamp)
        .get();

    // Iterate over each document
    for (var doc in querySnapshot.docs) {
      Timestamp timestamp = doc['dateCreated'];
      DateTime dateTime = timestamp.toDate();
      String dateString = DateFormat('yyyy-MM-dd').format(dateTime);

      dailyTicketCount.update(dateString, (count) => count + 1);
    }

    List<ColumnDataChart> chartData = dailyTicketCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }

  Stream<List<ColumnDataChart>> getMonthlyChartDataAggregate(
    String monthName,
    String yearString,
  ) async* {
    int month = monthName.month;
    int year = int.parse(yearString);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, int> monthlyTicketCount = {};
    int daysInMonth = DateTime(year, month + 1, 0).day;
    for (int day = 1; day <= daysInMonth; day++) {
      String dateString =
          DateFormat('yyyy-MM-dd').format(DateTime(year, month, day));
      monthlyTicketCount[dateString] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot querySnapshot = await tickets
        .where('dateCreated',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(year, month, 1)))
        .where('dateCreated',
            isLessThanOrEqualTo:
                Timestamp.fromDate(DateTime(year, month, daysInMonth)))
        .get();

    for (var doc in querySnapshot.docs) {
      Timestamp timestamp = doc['dateCreated'];
      DateTime dateTime = timestamp.toDate();
      String dateString = DateFormat('yyyy-MM-dd').format(dateTime);

      monthlyTicketCount.update(dateString, (count) => count + 1);
    }

    List<ColumnDataChart> chartData = monthlyTicketCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }

  Stream<List<ColumnDataChart>> getYearlyChartDataAggregate(
      String yearString) async* {
    int year = int.parse(yearString);
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Initialize the map with all months in the year and set count to 0
    Map<String, int> yearlyTicketCount = {};
    for (int month = 1; month <= 12; month++) {
      String monthString = DateFormat('yyyy-MM').format(DateTime(year, month));
      yearlyTicketCount[monthString] = 0;
    }

    // Get the tickets collection
    CollectionReference tickets = firestore.collection('tickets');

    // Get the documents created in the specified year
    QuerySnapshot querySnapshot = await tickets
        .where('dateCreated',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(year, 1, 1)))
        .where('dateCreated',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime(year, 12, 31)))
        .get();

    // Iterate over each document
    for (var doc in querySnapshot.docs) {
      // Get the dateCreated field and convert it to a month string
      Timestamp timestamp = doc['dateCreated'];
      DateTime dateTime = timestamp.toDate();
      String monthString = DateFormat('yyyy-MM').format(dateTime);

      // Increment the count for the corresponding month
      yearlyTicketCount.update(monthString, (count) => count + 1);
    }

    // Convert the map to a list of ColumnDataChart objects
    List<ColumnDataChart> chartData = yearlyTicketCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    print(chartData.first.column);

    // Yield the list of ColumnDataChart objects
    yield chartData;
  }
}
