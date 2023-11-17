import 'package:u_traffic_admin/config/exports/exports.dart';

class Enforcer {
  final String? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final EmployeeStatus status;
  final String photoUrl;
  final String employeeNumber;
  final String createdBy;
  final String updatedBy;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const Enforcer({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    this.status = EmployeeStatus.active,
    required this.photoUrl,
    required this.employeeNumber,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "status": status.toString().toEmployeeStatus,
      "photoUrl": photoUrl,
      "employeeNumber": employeeNumber,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory Enforcer.fromJson(Map<String, dynamic> json, String id) {
    return Enforcer(
      id: id,
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      email: json['email'],
      status: EmployeeStatus.values.firstWhere(
        (element) => element.toString().contains(json['status']),
      ),
      photoUrl: json['photoUrl'],
      employeeNumber: json['employeeNumber'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  @override
  String toString() {
    return "Enforcer(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName)";
  }
}
