import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleType {
  final String? id;
  final String typeName;
  final Timestamp dateCreated;
  final Timestamp? dateEdited;
  final String createdBy;
  final String editedBy;
  final bool isCommon;
  final bool isPublic;
  final bool isHidden;

  VehicleType({
    required this.id,
    required this.typeName,
    required this.dateCreated,
    required this.createdBy,
    required this.isCommon,
    this.dateEdited,
    this.editedBy = "",
    this.isPublic = false,
    this.isHidden = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'typeName': typeName,
      'dateCreated': dateCreated,
      'dateEdited': dateEdited,
      'createdBy': createdBy,
      'editedBy': editedBy,
      'isCommon': isCommon,
      'isPublic': isPublic,
      'isHidden': isHidden,
    };
  }

  factory VehicleType.fromJson(Map<String, dynamic> json, String id) {
    return VehicleType(
      id: id,
      typeName: json['typeName'],
      dateCreated: json['dateCreated'],
      dateEdited: json['dateEdited'],
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      isCommon: json['isCommon'],
      isPublic: json['isPublic'],
      isHidden: json['isHidden'],
    );
  }

  VehicleType copyWith({
    String? id,
    String? typeName,
    Timestamp? dateCreated,
    Timestamp? dateEdited,
    String? createdBy,
    String? editedBy,
    bool? isCommon,
    bool? isPublic,
    bool? isHidden,
  }) {
    return VehicleType(
      id: id ?? this.id,
      typeName: typeName ?? this.typeName,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEdited: dateEdited ?? this.dateEdited,
      createdBy: createdBy ?? this.createdBy,
      editedBy: editedBy ?? this.editedBy,
      isCommon: isCommon ?? this.isCommon,
      isPublic: isPublic ?? this.isPublic,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
