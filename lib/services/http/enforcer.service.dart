import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EnforcerHTTPSerivice {
  const EnforcerHTTPSerivice._();

  static const EnforcerHTTPSerivice _instance = EnforcerHTTPSerivice._();
  static EnforcerHTTPSerivice get instance => _instance;

  Future<String> createEnforcerAccount(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse(
              'http://localhost:3000/enforcer/create',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        return response.body;
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateEnforcerAccount(
    String uid,
    String email,
    String newPassword,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse(
              'http://localhost:3000/enforcer/update',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'uid': uid,
              'email': email,
              'password': newPassword,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw response.statusCode;
      }
    } on TimeoutException {
      rethrow;
    } on http.ClientException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
