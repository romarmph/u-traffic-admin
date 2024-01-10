class ViolationData {
  final String id;
  final String name;
  final int total;
  final int mondayCount;
  final int tuesdayCount;
  final int wednesdayCount;
  final int thursdayCount;
  final int fridayCount;
  final int saturdayCount;

  ViolationData({
    required this.id,
    required this.name,
    this.total = 0,
    this.mondayCount = 0,
    this.tuesdayCount = 0,
    this.wednesdayCount = 0,
    this.thursdayCount = 0,
    this.fridayCount = 0,
    this.saturdayCount = 0,
  });

  // CopyWith
  ViolationData copyWith({
    String? id,
    String? name,
    int? total,
    int? mondayCount,
    int? tuesdayCount,
    int? wednesdayCount,
    int? thursdayCount,
    int? fridayCount,
    int? saturdayCount,
  }) {
    return ViolationData(
      id: id ?? this.id,
      name: name ?? this.name,
      total: total ?? this.total,
      mondayCount: mondayCount ?? this.mondayCount,
      tuesdayCount: tuesdayCount ?? this.tuesdayCount,
      wednesdayCount: wednesdayCount ?? this.wednesdayCount,
      thursdayCount: thursdayCount ?? this.thursdayCount,
      fridayCount: fridayCount ?? this.fridayCount,
      saturdayCount: saturdayCount ?? this.saturdayCount,
    );
  }

  // To String
  @override
  String toString() {
    return 'ViolationData(id: $id, name: $name, total: $total, mondayCount: $mondayCount, tuesdayCount: $tuesdayCount, wednesdayCount: $wednesdayCount, thursdayCount: $thursdayCount, fridayCount: $fridayCount, saturdayCount: $saturdayCount)';
  }
}
