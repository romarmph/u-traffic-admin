import 'package:u_traffic_admin/config/exports/exports.dart';

class LicenseDetails {
  String? licenseID;
  String? userID;
  Timestamp? dateCreated;
  final String licenseNumber;
  final Timestamp expirationDate;
  final String driverName;
  final String address;
  final String nationality;
  final String sex;
  final Timestamp birthdate;
  final double height;
  final double weight;
  final String agencyCode;
  final String dlcodes;
  final String conditions;
  final String bloodType;
  final String eyesColor;

  LicenseDetails({
    this.userID,
    this.licenseID,
    this.dateCreated,
    required this.licenseNumber,
    required this.expirationDate,
    required this.driverName,
    required this.address,
    required this.nationality,
    required this.sex,
    required this.birthdate,
    required this.height,
    required this.weight,
    required this.agencyCode,
    required this.dlcodes,
    required this.conditions,
    required this.bloodType,
    required this.eyesColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "licenseNumber": licenseNumber,
      "expirationDate": expirationDate,
      "dateCreated": dateCreated,
      "driverName": driverName,
      "address": address,
      "nationality": nationality,
      "sex": sex,
      "birthdate": birthdate,
      "height": height,
      "weight": weight,
      "agencyCode": agencyCode,
      "dlcodes": dlcodes,
      "conditions": conditions,
      "bloodType": bloodType,
      "eyesColor": eyesColor,
      "userID": userID,
    };
  }

  factory LicenseDetails.fromJson(Map<String, dynamic> json) {
    return LicenseDetails(
      licenseNumber: json["licenseNumber"],
      expirationDate: json["expirationDate"],
      dateCreated: json["dateCreated"],
      driverName: json["driverName"],
      address: json["address"],
      nationality: json["nationality"],
      sex: json["sex"],
      birthdate: json["birthdate"],
      height: json["height"],
      weight: json["weight"],
      agencyCode: json["agencyCode"],
      dlcodes: json["dlcodes"],
      conditions: json["conditions"],
      bloodType: json['bloodType'],
      eyesColor: json['eyesColor'],
      userID: json['userID'],
    );
  }
}
