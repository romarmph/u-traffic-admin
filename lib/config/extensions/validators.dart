import 'package:u_traffic_admin/config/exports/exports.dart';

extension StringValidators on String {
  bool get isValidEmail {
    return EmailValidator.validate(this);
  }
}
