import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }
}

final loginFormControllerProvider = Provider<LoginFormController>((ref) {
  return LoginFormController();
});

final passwordVisibilityStateProvider = StateProvider<bool>((ref) {
  return true;
});

final emailErrorStateProvider = StateProvider<String?>((ref) {
  return null;
});

final passwordErrorStateProvider = StateProvider<String?>((ref) {
  return null;
});
