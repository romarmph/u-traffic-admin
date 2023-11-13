import 'package:u_traffic_admin/config/exports/exports.dart';

class Admin {
  final String? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String createdBy;
  final String updatedBy;
  final String employeeNo;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final bool isDisabled;
  final List<AdminPermission> permissions;

  const Admin({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isDisabled,
    required this.permissions,
    required this.employeeNo,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isDisabled": isDisabled,
      "employeeNo": employeeNo,
      "permissions": _toStringList(permissions),
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json, String id) {
    return Admin(
      id: id,
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      email: json['email'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      employeeNo: json['employeeNo'],
      isDisabled: json['isDisabled'],
      permissions: (json['permissions'] as List)
          .map((e) => AdminPermission.values.firstWhere(
              (element) => element.toString() == 'AdminPermission.$e'))
          .toList(),
    );
  }

  @override
  String toString() {
    return "Admin(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, : $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, isDisabled: $isDisabled, permissions: $permissions), employeeNo: $employeeNo";
  }

  List<String> _toStringList(List<AdminPermission> permissions) {
    return permissions.map((e) => e.toString().split('.').last).toList();
  }
}
