import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllEvidenceStreamProvider =
    StreamProvider.family<List<Evidence>, int>((ref, ticketNumber) {
  final evidences = EvidenceDatabase.instance.getEvidenceByTicketNumber(
    ticketNumber,
  );

  return evidences;
});

final getAllEvidenceProvider = Provider.family<List<Evidence>, int>((
  ref,
  ticketNumber,
) {
  return ref
      .watch(getAllEvidenceStreamProvider(
        ticketNumber,
      ))
      .when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
