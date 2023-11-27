import 'package:u_traffic_admin/config/exports/exports.dart';

class Driver {
  String? id;
  String firstName;
  String middleName;
  String lastName;
  Timestamp birthDate;
  String email;
  String phone;
  String photoUrl;
  bool isProfileComplete = false;

  Driver({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    this.photoUrl = "",
    required this.email,
    required this.phone,
    required this.isProfileComplete,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": birthDate,
      "photoUrl": photoUrl,
      "email": email,
      "phone": phone,
      "isProfileComplete": isProfileComplete,
    };
  }

  factory Driver.fromJson(Map<String, dynamic> json, String uid) {
    return Driver(
      id: uid,
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      birthDate: json["birthDate"],
      email: json["email"],
      photoUrl: json["photoUrl"] ?? "",
      phone: json["phone"] ?? "",
      isProfileComplete: json["isProfileComplete"],
    );
  }

  Driver copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    Timestamp? birthDate,
    String? email,
    String? phone,
    String? photoUrl,
    bool? isProfileComplete,
  }) {
    return Driver(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  String toString() {
    return "Driver(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, birthDate: $birthDate, email: $email, phone: $phone, isProfileComplete: $isProfileComplete, photoUrl: $photoUrl)";
  }
}
