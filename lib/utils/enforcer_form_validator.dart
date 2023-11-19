import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerFormValidator {
  String? validateFirstName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter first name';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter last name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter email';
    }

    if (!EmailValidator.validate(value!)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validateEmployeeNo(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter employee no.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      return 'Please enter password';
    }

    if (value != null && value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
}
