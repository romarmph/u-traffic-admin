class ColumnDataChart {
  final String column;
  final int count;

  ColumnDataChart({
    required this.column,
    required this.count,
  });

  ColumnDataChart copyWith({
    String? column,
    int? count,
  }) {
    return ColumnDataChart(
      column: column ?? this.column,
      count: count ?? this.count,
    );
  }
}
