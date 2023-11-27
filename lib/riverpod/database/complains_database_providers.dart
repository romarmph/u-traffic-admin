import 'package:u_traffic_admin/config/exports/exports.dart';

final getAllComplaintsProvider = StreamProvider<List<Complaint>>((ref) {
  return ComplaintsDatabase.instance.getComplaints();
});

final getComplaintByIdProvider =
    StreamProvider.autoDispose.family<Complaint, String>((ref, id) {
  return ComplaintsDatabase.instance.getComplaintById(id);
});

final getAllRepliesProvider = StreamProvider.autoDispose
    .family<List<Complaint>, String>((ref, parentThreadId) {
  return ComplaintsDatabase.instance.getAllReplies(parentThreadId);
});
