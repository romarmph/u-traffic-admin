import 'package:u_traffic_admin/config/exports/exports.dart';

class DataExports {
  final String? id;
  final String fileName;
  final String url;
  final String creatorName;
  final Timestamp createdAt;
  final String createdBy;

  DataExports({
    this.id,
    required this.fileName,
    required this.url,
    required this.creatorName,
    required this.createdAt,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'url': url,
      'creatorName': creatorName,
      'createdAt': createdAt,
      'createdBy': createdBy,
    };
  }

  factory DataExports.fromJson(Map<String, dynamic> json, String id) {
    return DataExports(
      id: id,
      fileName: json['fileName'] as String,
      url: json['url'] as String,
      creatorName: json['creatorName'] as String,
      createdAt: json['createdAt'] as Timestamp,
      createdBy: json['createdBy'] as String,
    );
  }

  DataExports copyWith({
    String? id,
    String? fileName,
    String? url,
    String? creatorName,
    Timestamp? createdAt,
    String? createdBy,
  }) {
    return DataExports(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      url: url ?? this.url,
      creatorName: creatorName ?? this.creatorName,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
