import 'package:u_traffic_admin/config/exports/exports.dart';

class Admin {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String roleID;
  final String createdBy;
  final String editedBy;
  final Timestamp dateCreated;
  final Timestamp dateEdited;
  final bool isDisabled;

  const Admin({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.roleID,
    required this.createdBy,
    required this.editedBy,
    required this.dateCreated,
    required this.dateEdited,
    required this.isDisabled,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "roleID": roleID,
      "createdBy": createdBy,
      "editedBy": editedBy,
      "dateCreated": dateCreated,
      "dateEdited": dateEdited,
      "isDisabled": isDisabled,
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json, String id) {
    return Admin(
      id: id,
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      email: json['email'],
      roleID: json['roleID'],
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      dateCreated: json['dateCreated'],
      dateEdited: json['dateEdited'],
      isDisabled: json['isDisabled'],
    );
  }

  @override
  String toString() {
    return "Admin(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, roleID: $roleID)";
  }
}
