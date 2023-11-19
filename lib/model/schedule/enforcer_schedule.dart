import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerSchedule {
  final String? id;
  final String enforcerId;
  final String enforcerName;
  final ShiftPeriod shift;
  final TimePeriod startTime;
  final TimePeriod endTime;
  final String postId;
  final String postName;
  final String createdBy;
  final String updatedBy;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  EnforcerSchedule({
    this.id,
    this.enforcerId = "",
    this.enforcerName = "",
    required this.shift,
    required this.startTime,
    required this.endTime,
    this.postId = "",
    this.postName = "",
    required this.createdBy,
    this.updatedBy = "",
    required this.createdAt,
    this.updatedAt,
  });

  factory EnforcerSchedule.fromJson(Map<String, dynamic> json, String id) {
    return EnforcerSchedule(
      id: id,
      enforcerId: json['enforcerId'],
      enforcerName: json['enforcerName'],
      shift: json['period'].toString().toShiftPeriod,
      startTime: TimePeriod.fromJson(json['startTime']),
      endTime: TimePeriod.fromJson(json['endTime']),
      postId: json['postId'],
      postName: json['postName'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enforcerId': enforcerId,
      'enforcerName': enforcerName,
      'shift': shift.name,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'postId': postId,
      'postName': postName,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  EnforcerSchedule copyWith({
    String? id,
    String? enforcerId,
    String? enforcerName,
    ShiftPeriod? shift,
    TimePeriod? startTime,
    TimePeriod? endTime,
    String? postId,
    String? postName,
    String? createdBy,
    String? updatedBy,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return EnforcerSchedule(
      id: id ?? this.id,
      enforcerId: enforcerId ?? this.enforcerId,
      enforcerName: enforcerName ?? this.enforcerName,
      shift: shift ?? this.shift,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      postId: postId ?? this.postId,
      postName: postName ?? this.postName,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
