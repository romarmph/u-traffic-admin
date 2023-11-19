class TimePeriod {
  final int hour;
  final int minute;
  final String period;

  TimePeriod({
    required this.hour,
    this.minute = 0,
    required this.period,
  });

  factory TimePeriod.fromJson(Map<String, dynamic> json) {
    return TimePeriod(
      hour: json['hour'],
      minute: json['minute'],
      period: json['period'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'period': period,
    };
  }
}
