import 'package:u_traffic_admin/config/exports/exports.dart';

class Notification {
  final String? id;
  final String receiver;
  final String title;
  final String body;
  final NotificationType type;
  final bool isRead;
  final bool isImmediate;
  final Timestamp createdAt;
  final Timestamp? readAt;
  final String createdBy;

  const Notification({
    this.id,
    required this.receiver,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    this.isImmediate = true,
    required this.createdAt,
    this.readAt,
    required this.createdBy,
  });
}
