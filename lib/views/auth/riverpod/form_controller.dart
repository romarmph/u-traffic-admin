import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginFormSettings {
  final formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (formKey.currentState!.validate()) {
      print('login');
    }
  }

  void dispose() {
    loginController.dispose();
    passwordController.dispose();
  }
}

final loginFormControllerProvider = Provider(
  (ref) => LoginFormSettings(),
);
