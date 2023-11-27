class Attachment {
  final String name;
  final String url;
  final String type;
  final int size;

  Attachment({
    required this.name,
    required this.url,
    required this.type,
    required this.size,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      name: json['name'],
      url: json['url'],
      type: json['type'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'type': type,
      'size': size,
    };
  }

  Attachment copyWith({
    String? name,
    String? url,
    String? type,
    int? size,
  }) {
    return Attachment(
      name: name ?? this.name,
      url: url ?? this.url,
      type: type ?? this.type,
      size: size ?? this.size,
    );
  }
}
