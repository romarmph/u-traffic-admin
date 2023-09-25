import 'package:u_traffic_admin/config/exports/exports.dart';

class Ticket {
  String? id;
  int? ticketNumber;
  final String licenseNumber;
  final String driverName;
  final String phone;
  final String email;
  final String address;
  final String vehicleTypeID;
  final String engineNumber;
  final String chassisNumber;
  final String plateNumber;
  final String vehicleOwner;
  final String vehicleOwnerAddress;
  final String enforcerID;
  final String enforcerName;
  final double totalFine;
  final Timestamp birthDate;
  final Timestamp dateCreated;
  final Timestamp ticketDueDate;
  final Timestamp violationDateTime;
  final List<String?> violationsID;
  final ULocation violationPlace;
  final TicketStatus status;
  final String? licenseFrontImageUrl;
  final String? licenseBackImageUrl;
  final String? signatureImageUrl;
  final List<String>? evidenceImagesUrl;

  Ticket({
    this.id,
    this.ticketNumber,
    this.licenseFrontImageUrl,
    this.licenseBackImageUrl,
    this.signatureImageUrl,
    this.evidenceImagesUrl,
    required this.licenseNumber,
    required this.driverName,
    required this.phone,
    required this.email,
    required this.address,
    required this.vehicleTypeID,
    required this.engineNumber,
    required this.chassisNumber,
    required this.plateNumber,
    required this.vehicleOwner,
    required this.vehicleOwnerAddress,
    required this.enforcerID,
    required this.enforcerName,
    required this.totalFine,
    required this.status,
    required this.birthDate,
    required this.dateCreated,
    required this.ticketDueDate,
    required this.violationDateTime,
    required this.violationPlace,
    required this.violationsID,
  });

  factory Ticket.fromJson(Map<String, dynamic> json, [String? id]) {
    return Ticket(
      id: id,
      ticketNumber: json['ticketNumber'],
      licenseNumber: json['licenseNumber'],
      driverName: json['driverName'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      vehicleTypeID: json['vehicleTypeID'],
      engineNumber: json['engineNumber'],
      chassisNumber: json['chassisNumber'],
      plateNumber: json['plateNumber'],
      vehicleOwner: json['vehicleOwner'],
      vehicleOwnerAddress: json['vehicleOwnerAddress'],
      enforcerID: json['enforcerID'],
      enforcerName: json['enforcerName'],
      totalFine: json['totalFine'] as double,
      status: TicketStatus.values.firstWhere(
        (e) => e.toString() == 'TicketStatus.${json['status']}',
      ),
      birthDate: json['birthDate'],
      dateCreated: json['dateCreated'],
      ticketDueDate: json['ticketDueDate'],
      violationDateTime: json['violationDateTime'],
      violationPlace: ULocation.fromJson(json['violationPlace']),
      violationsID: List<String?>.from(json['violationsID'] ?? []),
      licenseFrontImageUrl: json['licenseFrontImageUrl'],
      licenseBackImageUrl: json['licenseBackImageUrl'],
      signatureImageUrl: json['signatureImageUrl'],
      evidenceImagesUrl: List<String>.from(json['evidenceImagesUrl'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketNumber': ticketNumber,
      'licenseNumber': licenseNumber,
      'driverName': driverName,
      'phone': phone,
      'email': email,
      'address': address,
      'vehicleTypeID': vehicleTypeID,
      'engineNumber': engineNumber,
      'chassisNumber': chassisNumber,
      'plateNumber': plateNumber,
      'vehicleOwner': vehicleOwner,
      'vehicleOwnerAddress': vehicleOwnerAddress,
      'enforcerID': enforcerID,
      'enforcerName': enforcerName,
      'totalFine': totalFine,
      'status': status.toString().split('.').last,
      'birthDate': birthDate,
      'dateCreated': dateCreated,
      'ticketDueDate': ticketDueDate,
      'violationDateTime': violationDateTime,
      'violationPlace': violationPlace.toJson(),
      'violationsID': violationsID,
      'licenseFrontImageUrl': licenseFrontImageUrl,
      'licenseBackImageUrl': licenseBackImageUrl,
      'signatureImageUrl': signatureImageUrl,
      'evidenceImagesUrl': evidenceImagesUrl,
    };
  }

  @override
  String toString() {
    return "Ticket: ${toJson().toString()}";
  }

  dynamic operator [](String key) => toJson()[key];

  Map<String, dynamic> map(Function(String key, dynamic value) f) {
    Map<String, dynamic> result = {};

    toJson().forEach((key, value) {
      result.addAll(f(key, value));
    });

    return result;
  }

  Ticket copyWith({
    String? id,
    int? ticketNumber,
    String? licenseNumber,
    String? driverName,
    String? phone,
    String? email,
    String? address,
    String? vehicleTypeID,
    String? engineNumber,
    String? chassisNumber,
    String? plateNumber,
    String? vehicleOwner,
    String? vehicleOwnerAddress,
    String? enforcerID,
    String? enforcerName,
    double? totalFine,
    TicketStatus? status,
    Timestamp? birthDate,
    Timestamp? dateCreated,
    Timestamp? ticketDueDate,
    Timestamp? violationDateTime,
    ULocation? violationPlace,
    List<String?>? violationsID,
    String? licenseFrontImageUrl,
    String? licenseBackImageUrl,
    String? signatureImageUrl,
    List<String>? evidenceImagesUrl,
  }) {
    return Ticket(
      id: id ?? this.id,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      driverName: driverName ?? this.driverName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      vehicleTypeID: vehicleTypeID ?? this.vehicleTypeID,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      plateNumber: plateNumber ?? this.plateNumber,
      vehicleOwner: vehicleOwner ?? this.vehicleOwner,
      vehicleOwnerAddress: vehicleOwnerAddress ?? this.vehicleOwnerAddress,
      enforcerID: enforcerID ?? this.enforcerID,
      enforcerName: enforcerName ?? this.enforcerName,
      totalFine: totalFine ?? this.totalFine,
      status: status ?? this.status,
      birthDate: birthDate ?? this.birthDate,
      dateCreated: dateCreated ?? this.dateCreated,
      ticketDueDate: ticketDueDate ?? this.ticketDueDate,
      violationDateTime: violationDateTime ?? this.violationDateTime,
      violationPlace: violationPlace ?? this.violationPlace,
      violationsID: violationsID ?? this.violationsID,
      licenseFrontImageUrl: licenseFrontImageUrl ?? this.licenseFrontImageUrl,
      licenseBackImageUrl: licenseBackImageUrl ?? this.licenseBackImageUrl,
      signatureImageUrl: signatureImageUrl ?? this.signatureImageUrl,
      evidenceImagesUrl: evidenceImagesUrl ?? this.evidenceImagesUrl,
    );
  }
}
