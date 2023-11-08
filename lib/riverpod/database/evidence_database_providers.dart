import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllEvidenceStreamProvider =
    StreamProvider.family<List<Evidence>, String>((ref, ticketID) {
  final evidences = EvidenceDatabase.instance.getEvidenceByTicketNumber(
    ticketID,
  );

  return evidences;
});

final getAllEvidenceProvider = Provider.family<List<Evidence>, String>((
  ref,
  ticketID,
) {
  return ref
      .watch(getAllEvidenceStreamProvider(
        ticketID,
      ))
      .when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
