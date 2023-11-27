import 'package:u_traffic_admin/config/exports/exports.dart';

class Complaint {
  final String? id;
  final String title;
  final String description;
  final String status;
  final String? parentThread;
  final Timestamp createdAt;
  final Timestamp? closedAt;
  final Timestamp? reopenedAt;
  final bool isFromDriver;
  final String sender;
  final String closedBy;
  final String reopenedBy;
  final List<Attachment> attachments;
  final String attachedTicket;
  final bool isSoftDeleted;

  Complaint({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.sender,
    this.parentThread,
    this.status = "open",
    this.closedAt,
    this.closedBy = "",
    this.reopenedBy = "",
    this.reopenedAt,
    this.attachments = const [],
    this.attachedTicket = "",
    this.isSoftDeleted = false,
    this.isFromDriver = true,
  });

  factory Complaint.fromJson(Map<String, dynamic> json, String uid) {
    return Complaint(
      id: uid,
      title: json['title'],
      description: json['description'],
      status: json['status'],
      parentThread: json['parentThread'],
      createdAt: json['createdAt'],
      closedAt: json['closedAt'],
      sender: json['sender'],
      reopenedAt: json['reopenedAt'],
      reopenedBy: json['reopenedBy'],
      closedBy: json['closedBy'],
      attachments: List.from(json['attachments'])
          .map((e) => Attachment.fromJson(e))
          .toList(),
      attachedTicket: json['attachedTicket'],
      isSoftDeleted: json['isSoftDeleted'],
      isFromDriver: json['isFromDriver'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'parentThread': parentThread,
      'createdAt': createdAt,
      'closedAt': closedAt,
      'sender': sender,
      'reopenedAt': reopenedAt,
      'reopenedBy': reopenedBy,
      'closedBy': closedBy,
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'attachedTicket': attachedTicket,
      'isSoftDeleted': isSoftDeleted,
      'isFromDriver': isFromDriver,
    };
  }

  Complaint copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? status,
    String? parentThread,
    Timestamp? createdAt,
    Timestamp? closedAt,
    String? sender,
    String? reopenedBy,
    Timestamp? reopenedAt,
    String? closedBy,
    List<Attachment>? attachments,
    String? attachedTicket,
    bool? isSoftDeleted,
    bool? isFromDriver,
  }) {
    return Complaint(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      parentThread: parentThread ?? this.parentThread,
      createdAt: createdAt ?? this.createdAt,
      closedAt: closedAt ?? this.closedAt,
      sender: sender ?? this.sender,
      closedBy: closedBy ?? this.closedBy,
      attachments: attachments ?? this.attachments,
      attachedTicket: attachedTicket ?? this.attachedTicket,
      reopenedAt: reopenedAt ?? this.reopenedAt,
      reopenedBy: reopenedBy ?? this.reopenedBy,
      isSoftDeleted: isSoftDeleted ?? this.isSoftDeleted,
      isFromDriver: isFromDriver ?? this.isFromDriver,
    );
  }

  @override
  String toString() {
    return 'Complaint(id: $id, title: $title, description: $description, status: $status, parentThread: $parentThread, createdAt: $createdAt, closedAt: $closedAt, sender: $sender, closedBy: $closedBy, attachments: $attachments, attachedTicket: $attachedTicket, reopenedAt: $reopenedAt, reopenedBy: $reopenedBy, isSoftDeleted: $isSoftDeleted, isFromDriver: $isFromDriver)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complaint &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.parentThread == parentThread &&
        other.createdAt == createdAt &&
        other.closedAt == closedAt &&
        other.sender == sender &&
        other.closedBy == closedBy &&
        other.attachments == attachments &&
        other.attachedTicket == attachedTicket &&
        other.reopenedAt == reopenedAt &&
        other.reopenedBy == reopenedBy &&
        other.isSoftDeleted == isSoftDeleted &&
        other.isFromDriver == isFromDriver;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        parentThread.hashCode ^
        createdAt.hashCode ^
        closedAt.hashCode ^
        sender.hashCode ^
        closedBy.hashCode ^
        attachments.hashCode ^
        attachedTicket.hashCode ^
        reopenedAt.hashCode ^
        reopenedBy.hashCode ^
        isSoftDeleted.hashCode ^
        isFromDriver.hashCode;
  }
}
