import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDetail {
  final String? id;
  final PaymentMethod method;
  final double fineAmount;
  final double tenderedAmount;
  final double change;
  final int ticketNumber;
  final String ticketID;
  final String processedBy;
  final String processedByName;
  final Timestamp processedAt;

  const PaymentDetail({
    this.id,
    required this.method,
    required this.fineAmount,
    required this.tenderedAmount,
    required this.change,
    required this.ticketNumber,
    required this.ticketID,
    required this.processedBy,
    required this.processedAt,
    required this.processedByName,
  });

  Map<String, dynamic> toJson() {
    return {
      'method': method.toString().split('.').last,
      'fineAmount': fineAmount,
      'tenderedAmount': tenderedAmount,
      'change': change,
      'ticketNumber': ticketNumber,
      'ticketID': ticketID,
      'processedBy': processedBy,
      'processedAt': processedAt,
      'processedByName': processedByName,
    };
  }

  factory PaymentDetail.fromJson(Map<String, dynamic> json, [String? docId]) {
    return PaymentDetail(
      id: docId,
      method: PaymentMethod.values.firstWhere(
        (element) => element.toString() == 'PaymentMethod.${json['method']}',
      ),
      fineAmount: json['fineAmount'],
      tenderedAmount: json['tenderedAmount'],
      change: json['change'],
      ticketNumber: json['ticketNumber'],
      ticketID: json['ticketID'],
      processedBy: json['processedBy'],
      processedByName: json['processedByName'],
      processedAt: json['processedAt'],
    );
  }

  PaymentDetail copyWith({
    String? id,
    PaymentMethod? method,
    double? fineAmount,
    double? tenderedAmount,
    double? change,
    int? ticketNumber,
    String? ticketID,
    String? processedBy,
    String? processedByName,
    Timestamp? processedAt,
    String? editedBy,
    Timestamp? editedAt,
  }) {
    return PaymentDetail(
      id: id ?? this.id,
      method: method ?? this.method,
      fineAmount: fineAmount ?? this.fineAmount,
      tenderedAmount: tenderedAmount ?? this.tenderedAmount,
      change: change ?? this.change,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      ticketID: ticketID ?? this.ticketID,
      processedBy: processedBy ?? this.processedBy,
      processedByName: processedByName ?? this.processedByName,
      processedAt: processedAt ?? this.processedAt,
    );
  }
}
