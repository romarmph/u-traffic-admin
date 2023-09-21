class CustomException implements Exception {
  final String code;
  final String message;

  const CustomException({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return 'CustomException{code: $code, message: $message}';
  }

  @override
  int get hashCode => code.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomException && other.code == code;
  }
}

class CustomExceptions {
  static CustomException adminNotFound = const CustomException(
    message: 'Admin account not found',
    code: 'admin-not-found',
  );

  static CustomException adminDisabled = const CustomException(
    message: 'Admin account is disabled',
    code: 'admin-disabled',
  );

  static CustomException adminAlreadyExists = const CustomException(
    message: 'Admin account already exists',
    code: 'admin-already-exists',
  );

  static CustomException adminNotLoggedIn = const CustomException(
    message: 'Admin account not logged in',
    code: 'admin-not-logged-in',
  );

  static CustomException incorrectPassword = const CustomException(
    message: 'Incorrect password',
    code: 'incorrect-password',
  );

  static CustomException tooManyRequests = const CustomException(
    message: 'Consecutive incorrect login attempts. Please try again later',
    code: 'too-many-requests',
  );
}
