import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/model/analytics/violation_data.dart';

class ViolationsAggregate {
  const ViolationsAggregate._();

  static const ViolationsAggregate _instance = ViolationsAggregate._();
  static ViolationsAggregate get instance => _instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _violations = _firestore.collection('violations');
  static final _tickets = _firestore.collection('tickets');

  Stream<List<ViolationData>> getViolationsByDay() async* {
    final violationsDocs = await _violations.get();
    final ticketDocs = await _tickets.get();
    final List<Ticket> tickets = ticketDocs.docs
        .map((e) => Ticket.fromJson(
              e.data(),
              e.id,
            ))
        .toList();

    final List<Violation> violations = violationsDocs.docs
        .map((e) => Violation.fromJson(
              e.data(),
              e.id,
            ))
        .toList();

    final List<ViolationData> violationData = [];
    for (final violation in violations) {
      final totalCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions
            .any((element) => element.violationID == violation.id);
      }).length;

      final mondayCount = tickets.where((e) {
        final issuedViolations = e.issuedViolations;
        return issuedViolations.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.monday);
      }).length;

      final tuesdayCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.tuesday);
      }).length;

      final wednesdayCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.wednesday);
      }).length;

      final thursdayCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.thursday);
      }).length;

      final fridayCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.friday);
      }).length;

      final saturdayCount = tickets.where((e) {
        final issuedVioaltions = e.issuedViolations;

        return issuedVioaltions.any((element) =>
            element.violationID == violation.id &&
            e.dateCreated.dayOfTheWeek == DateTime.saturday);
      }).length;

      violationData.add(
        ViolationData(
          id: violation.id!,
          name: violation.name,
          total: totalCount,
          mondayCount: mondayCount,
          tuesdayCount: tuesdayCount,
          wednesdayCount: wednesdayCount,
          thursdayCount: thursdayCount,
          fridayCount: fridayCount,
          saturdayCount: saturdayCount,
        ),
      );
    }
    yield violationData;
  }
}
