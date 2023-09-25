import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleType {
  final String id;
  final String typeName;
  final Timestamp dateCreated;
  final Timestamp dateEdited;
  final String createdBy;
  final String editedBy;
  final bool isCommon;

  VehicleType({
    required this.id,
    required this.typeName,
    required this.dateCreated,
    required this.dateEdited,
    required this.createdBy,
    required this.editedBy,
    required this.isCommon,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json, String id) {
    return VehicleType(
      id: id,
      typeName: json['typeName'],
      dateCreated: json['dateCreated'],
      dateEdited: json['dateEdited'],
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      isCommon: json['isCommon'],
    );
  }
}