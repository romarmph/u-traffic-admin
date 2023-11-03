import 'package:u_traffic_admin/config/exports/exports.dart';

class PaymentDetail {
  final String? id;
  final PaymentMethod method;
  final double fineAmount;
  final double tenderedAmount;
  final int ticketNumber;
  final String processedBy;
  final Timestamp processedAt;
  final String editedBy;
  final Timestamp editedAt;

  const PaymentDetail({
    this.id,
    required this.method,
    required this.fineAmount,
    required this.tenderedAmount,
    required this.ticketNumber,
    required this.processedBy,
    required this.processedAt,
    required this.editedBy,
    required this.editedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'fineAmount': fineAmount,
      'tenderedAmount': tenderedAmount,
      'ticketNumber': ticketNumber,
      'processedBy': processedBy,
      'processedAt': processedAt,
      'editedBy': editedBy,
      'editedAt': editedAt,
    };
  }

  factory PaymentDetail.fromJson(Map<String, dynamic> json, [String? docId]) {
    return PaymentDetail(
      id: docId,
      method: json['method'],
      fineAmount: json['fineAmount'],
      tenderedAmount: json['tenderedAmount'],
      ticketNumber: json['ticketNumber'],
      processedBy: json['processedBy'],
      processedAt: json['processedAt'],
      editedBy: json['editedBy'],
      editedAt: json['editedAt'],
    );
  }

  PaymentDetail copyWith({
    String? id,
    PaymentMethod? method,
    double? fineAmount,
    double? tenderedAmount,
    int? ticketNumber,
    String? processedBy,
    Timestamp? processedAt,
    String? editedBy,
    Timestamp? editedAt,
  }) {
    return PaymentDetail(
      id: id ?? this.id,
      method: method ?? this.method,
      fineAmount: fineAmount ?? this.fineAmount,
      tenderedAmount: tenderedAmount ?? this.tenderedAmount,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      processedBy: processedBy ?? this.processedBy,
      processedAt: processedAt ?? this.processedAt,
      editedBy: editedBy ?? this.editedBy,
      editedAt: editedAt ?? this.editedAt,
    );
  }
}
