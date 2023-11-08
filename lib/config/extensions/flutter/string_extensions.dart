extension StringExtension on String {
  DateTime get toDateTime {
    return DateTime.parse(this);
  }

  String get capitalize {
    return split('').first.toUpperCase() + substring(1);
  }
}
