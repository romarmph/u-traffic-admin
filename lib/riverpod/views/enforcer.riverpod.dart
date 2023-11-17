import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final enforcerShiftQuertProvider = StateProvider<String>((ref) {
  return 'all';
});

final enforcerSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

class EnforcerForm extends ChangeNotifier {
  Uint8List? profileImage;
  String scheduleId = '';

  void setProfileImage(Uint8List path) {
    profileImage = path;
    notifyListeners();
  }

  void setScheduleId(String value) {
    scheduleId = value;
    notifyListeners();
  }

  void reset() {
    profileImage = null;
    scheduleId = '';
    notifyListeners();
  }
}

final enforcerFormProvider = ChangeNotifierProvider<EnforcerForm>((ref) {
  return EnforcerForm();
});
