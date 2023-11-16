import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerSchedule {
  final String? id;
  final String enforcerId;
  final ShiftPeriod shift;
  final TimePeriod startTime;
  final TimePeriod endTime;
  final String postId;
  final String createdBy;
  final String updatedBy;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  EnforcerSchedule({
    this.id,
    required this.enforcerId,
    required this.shift,
    required this.startTime,
    required this.endTime,
    required this.postId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EnforcerSchedule.fromJson(Map<String, dynamic> json, String id) {
    return EnforcerSchedule(
      id: id,
      enforcerId: json['enforcerId'],
      shift: json['period'].toString().toShiftPeriod,
      startTime: TimePeriod.fromJson(json['startTime']),
      endTime: TimePeriod.fromJson(json['endTime']),
      postId: json['postId'],
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
      'shift': shift.name,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'postId': postId,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  EnforcerSchedule copyWith({
    String? id,
    String? enforcerId,
    ShiftPeriod? shift,
    TimePeriod? startTime,
    TimePeriod? endTime,
    String? postId,
    String? createdBy,
    String? updatedBy,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return EnforcerSchedule(
      id: id ?? this.id,
      enforcerId: enforcerId ?? this.enforcerId,
      shift: shift ?? this.shift,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      postId: postId ?? this.postId,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
