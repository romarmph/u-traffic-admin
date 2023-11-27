class ViolationOffense {
  final int level;
  final int fine;
  final String penalty;

  ViolationOffense({
    required this.level,
    required this.fine,
    this.penalty = "",
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

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is ViolationOffense &&
  //       other.level == level &&
  //       other.fine == fine &&
  //       other.penalty == penalty;
  // }

  // @override
  // int get hashCode => level.hashCode ^ fine.hashCode ^ penalty.hashCode;
}
