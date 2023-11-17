import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerShiftQuertProvider = StateProvider<String>((ref) {
  return 'all';
});

final enforcerSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

class EnforcerFrom extends ChangeNotifier {
  String profilePhotoPath = '';
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String employeeNumber = '';
  String email = '';

  void setProfilePhotoPath(String path) {
    profilePhotoPath = path;
    notifyListeners();
  }

  void setFirstName(String name) {
    firstName = name;
    notifyListeners();
  }

  void setMiddleName(String name) {
    middleName = name;
    notifyListeners();
  }

  void setLastName(String name) {
    lastName = name;
    notifyListeners();
  }

  void setEmployeeNumber(String number) {
    employeeNumber = number;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void reset() {
    profilePhotoPath = '';
    firstName = '';
    middleName = '';
    lastName = '';
    employeeNumber = '';
    email = '';
    notifyListeners();
  }
}

final enforcerFormProvider = ChangeNotifierProvider<EnforcerFrom>((ref) {
  return EnforcerFrom();
});
