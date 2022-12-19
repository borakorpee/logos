import 'dart:convert';

import '../screens/forgot_pass/email_OTP.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future isEmailExists(String email) async {
    var response =
        await http.get(Uri.parse("$root/client/reset?email=${email}"));

    return jsonDecode(response.body);
  }

  static Future resetPass(String token, String pass) async {
    var response = await http.put(Uri.parse("$root/client/reset/pass"), body: {
      "token": token,
      "pass": pass,
    });
    return jsonDecode(response.body);
  }
}
