import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';

import '../../utilities/imports.dart';

class ProfileAPI{
  static Future<http.Response> register(String email, String password, String role, String confirmPassword) async {
    return await http.post(Uri.parse("$SERVERDOMAIN/user/register"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': await UserSecureStorage.getEmail(),
          'password': await UserSecureStorage.getPassword(),
          'role': await UserSecureStorage.getRole(),
          'confirmPassword':
          await UserSecureStorage.getConfirmPassword(),
        }));

  }
}