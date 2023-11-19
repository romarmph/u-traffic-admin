class ViolationOffense {
  final int level;
  final int fine;
  final String penalty;

  ViolationOffense({
    required this.level,
    required this.fine,
    required this.penalty,
  });

  factory ViolationOffense.fromJson(Map<String, dynamic> json) {
    return ViolationOffense(
      level: json['level'],
      fine: json['fine'],
      penalty: json['penalty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'fine': fine,
      'penalty': penalty,
    };
  }
}