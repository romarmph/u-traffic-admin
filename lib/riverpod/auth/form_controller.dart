import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

///
/// Controller and form providers
///
final loginFormKeyProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
