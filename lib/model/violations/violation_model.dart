import 'package:u_traffic_admin/config/exports/exports.dart';

class Violation {
  final String? id;
  final int fine;
  final String name;
  final bool isDisabled;
  final List<ViolationOffense> offense;
  final String createdBy;
  final String editedBy;
  final Timestamp dateCreated;
  final Timestamp? dateEdited;
  bool isSelected;

  Violation({
    this.isSelected = false,
    this.isDisabled = false,
    this.id,
    required this.fine,
    required this.name,
    required this.offense,
    required this.createdBy,
    this.editedBy = "",
    required this.dateCreated,
    this.dateEdited,
  });

  factory Violation.fromJson(Map<String, dynamic> json, String id) {
    return Violation(
      id: id,
      fine: json['fine'],
      name: json['name'],
      isDisabled: json['isDisabled'] ?? false,
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
      'offense': offense.map((e) => e.toJson()).toList(),
      'isDisabled': isDisabled,
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
    bool? isDisabled,
    String? createdBy,
    String? editedBy,
    Timestamp? dateCreated,
    Timestamp? dateEdited,
  }) {
    return Violation(
      id: id ?? this.id,
      fine: fine ?? this.fine,
      name: name ?? this.name,
      isDisabled: isDisabled ?? this.isDisabled,
      offense: offense ?? this.offense,
      createdBy: createdBy ?? this.createdBy,
      editedBy: editedBy ?? this.editedBy,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEdited: dateEdited ?? this.dateEdited,
    );
  }
}
