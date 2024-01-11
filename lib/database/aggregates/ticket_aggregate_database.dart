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
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, int> yearlyTicketCount = {};
    for (int month = 1; month <= 12; month++) {
      String monthString = DateFormat('yyyy-MM').format(DateTime(year, month));
      yearlyTicketCount[monthString] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot querySnapshot = await tickets
        .where('dateCreated',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(year, 1, 1)))
        .where('dateCreated',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime(year, 12, 31)))
        .get();

    for (var doc in querySnapshot.docs) {
      Timestamp timestamp = doc['dateCreated'];
      DateTime dateTime = timestamp.toDate();
      String monthString = DateFormat('yyyy-MM').format(dateTime);

      yearlyTicketCount.update(monthString, (count) => count + 1);
    }

    List<ColumnDataChart> chartData = yearlyTicketCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }

  Stream<List<ColumnDataChart>> mostIssuedViolations(
      DateTime start, DateTime end) async* {
    Timestamp startTimestamp = Timestamp.fromDate(start);
    Timestamp endTimestamp = Timestamp.fromDate(end);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference violations = firestore.collection('violations');

    QuerySnapshot violationSnapshot = await violations.get();

    Map<String, int> violationCount = {};
    for (var doc in violationSnapshot.docs) {
      String violationName = doc['name'];
      violationCount[violationName] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot ticketSnapshot = await tickets
        .where('dateCreated', isGreaterThanOrEqualTo: startTimestamp)
        .where('dateCreated', isLessThanOrEqualTo: endTimestamp)
        .get();

    for (var doc in ticketSnapshot.docs) {
      List<IssuedViolation> issuedViolations = [];

      for (var issuedViolation in doc['issuedViolations']) {
        issuedViolations.add(IssuedViolation.fromJson(issuedViolation));
      }

      for (var violation in issuedViolations) {
        String violationName = violation.violation;

        if (violationCount.containsKey(violationName)) {
          violationCount.update(violationName, (count) => count + 1);
        }
      }
    }

    List<ColumnDataChart> chartData = violationCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }

  Stream<List<ColumnDataChart>> getMonthViolationData(
      String monthName, String yearString) async* {
    DateFormat format = DateFormat("MMMM yyyy");
    DateTime dateTime = format.parse("$monthName $yearString");
    int year = dateTime.year;
    int month = dateTime.month;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference violations = firestore.collection('violations');

    QuerySnapshot violationSnapshot = await violations.get();

    Map<String, int> violationCount = {};
    for (var doc in violationSnapshot.docs) {
      String violationName = doc['name'];
      violationCount[violationName] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot ticketSnapshot = await tickets
        .where('dateCreated',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(year, month, 1)))
        .where('dateCreated',
            isLessThanOrEqualTo: Timestamp.fromDate(
                DateTime(year, month, DateTime(year, month + 1, 0).day)))
        .get();

    for (var doc in ticketSnapshot.docs) {
      List<IssuedViolation> issuedViolations = [];

      for (var val in doc['issuedViolations']) {
        issuedViolations.add(IssuedViolation.fromJson(val));
      }

      for (var violation in issuedViolations) {
        String violationName = violation.violation;

        if (violationCount.containsKey(violationName)) {
          violationCount.update(violationName, (count) => count + 1);
        }
      }
    }

    List<ColumnDataChart> chartData = violationCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }

  Stream<List<ColumnDataChart>> getYearlyViolationData(
      String yearString) async* {
    int year = int.parse(yearString);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference violations = firestore.collection('violations');

    QuerySnapshot violationSnapshot = await violations.get();

    Map<String, int> violationCount = {};
    for (var doc in violationSnapshot.docs) {
      String violationName = doc['name'];
      violationCount[violationName] = 0;
    }

    CollectionReference tickets = firestore.collection('tickets');

    QuerySnapshot ticketSnapshot = await tickets
        .where('dateCreated',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(year, 1, 1)))
        .where('dateCreated',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime(year, 12, 31)))
        .get();

    for (var doc in ticketSnapshot.docs) {
      List<IssuedViolation> issuedViolations = [];

      for (var val in doc['issuedViolations']) {
        issuedViolations.add(IssuedViolation.fromJson(val));
      }

      for (var violation in issuedViolations) {
        String violationName = violation.violation;

        if (violationCount.containsKey(violationName)) {
          violationCount.update(violationName, (count) => count + 1);
        }
      }
    }

    List<ColumnDataChart> chartData = violationCount.entries.map((entry) {
      return ColumnDataChart(column: entry.key, count: entry.value);
    }).toList();

    yield chartData;
  }
}
