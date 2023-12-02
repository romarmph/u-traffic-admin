class DailyChartData {
  final int day;
  final int count;

  DailyChartData({
    required this.day,
    required this.count,
  });
}

class MonthLyChartData {
  final String month;
  final int count;

  MonthLyChartData({
    required this.month,
    required this.count,
  });
}

class YearlyChartData {
  final String year;
  final int count;

  YearlyChartData({
    required this.year,
    required this.count,
  });
}