import 'dart:convert';

import '../screens/forgot_pass/email_OTP.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future isEmailExists(String email) async {
    var response = await http.get(Uri.parse("$root/client/reset?email=$email"));

    return jsonDecode(response.body);
  }

  static Future resetPass(String token, String pass) async {
    var response = await http.put(Uri.parse("$root/client/reset/pass"), body: {
      "token": token,
      "pass": pass,
    });
    return jsonDecode(response.body);
  }

  static Future registerClient(
      Map<String, dynamic> args, String pass, String mail) async {
    var response = await http.post(Uri.parse('$root/client/add'), body: {
      'name': args["name"],
      'surname': args["surname"],
      'pass': pass,
      'email': mail,
      'birth': args["birth"],
      'city': args["city"],
      'county': args["county"],
      'job': args["job"],
      'sex': args["sex"],
    });
    return jsonDecode(response.body);
  }

  static Future login(String mail, String pass) async {
    var response = await http.post(
        Uri.parse(
          "$root/client/login",
        ),
        body: {
          'email': mail,
          'pass': pass,
        });

    return jsonDecode(response.body);
  }
}
