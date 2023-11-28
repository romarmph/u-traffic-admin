class Evidence {
  final String? id;
  final String name;
  final String? description;
  final String path;
  final int ticketNumber;

  const Evidence({
    this.id,
    required this.name,
    required this.description,
    required this.path,
    required this.ticketNumber,
  });

  factory Evidence.fromJson(Map<String, dynamic> json, [String? evidenceID]) {
    return Evidence(
      id: evidenceID,
      name: json['name'],
      description: json['description'],
      path: json['path'],
      ticketNumber: json['ticketNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'path': path,
      'ticketNumber': ticketNumber,
    };
  }
}
