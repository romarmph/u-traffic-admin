class PaymentGridFields {
  static const String orNumber = 'orNumber';
  static const String ticketNumber = 'ticketNumber';
  static const String fineAmount = 'fineAmount';
  static const String tenderedAmount = 'tenderedAmount';
  static const String change = 'change';
  static const String datePaid = 'datePaid';
  static const String processedBy = 'processedBy';
  static const String processedByName = 'processedByName';
  static const String actions = 'actions';

  String get name => toString().split('.').last;
}
