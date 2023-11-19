import 'package:u_traffic_admin/config/exports/exports.dart';

class Violation {
  final String? id;
  final int fine;
  final String name;
  final List<ViolationOffense> offense;
  final String createdBy;
  final String editedBy;
  final Timestamp dateCreated;
  final Timestamp dateEdited;
  bool isSelected;

  Violation({
    this.isSelected = false,
    required this.id,
    required this.fine,
    required this.name,
    required this.offense,
    required this.createdBy,
    required this.editedBy,
    required this.dateCreated,
    required this.dateEdited,
  });

  factory Violation.fromJson(Map<String, dynamic> json, String id) {
    return Violation(
      id: id,
      fine: json['fine'],
      name: json['name'],
      offense: List<Map<String, dynamic>>.from(json['offense'])
          .map((e) => ViolationOffense.fromJson(e))
          .toList(),
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      dateCreated: json['dateCreated'],
      dateEdited: json['dateEdited'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fine': fine,
      'name': name,
      'offense': offense,
      'createdBy': createdBy,
      'editedBy': editedBy,
      'dateCreated': dateCreated,
      'dateEdited': dateEdited,
    };
  }

  Violation copyWith({
    String? id,
    int? fine,
    String? name,
    List<ViolationOffense>? offense,
    String? createdBy,
    String? editedBy,
    Timestamp? dateCreated,
    Timestamp? dateEdited,
  }) {
    return Violation(
      id: id ?? this.id,
      fine: fine ?? this.fine,
      name: name ?? this.name,
      offense: offense ?? this.offense,
      createdBy: createdBy ?? this.createdBy,
      editedBy: editedBy ?? this.editedBy,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEdited: dateEdited ?? this.dateEdited,
    );
  }
}
