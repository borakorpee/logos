// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:provider/provider.dart';

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

  static Future login(String mail, String pass, BuildContext context) async {
    var response = await http.post(
        Uri.parse(
          "$root/client/login",
        ),
        body: {
          'email': mail,
          'pass': pass,
        });
    var data = jsonDecode(response.body);
    log(data.toString());

    if (data["status"]) {
      var all_psycs = await http.get(Uri.parse("$root/psyc/psycs"), headers: {
        'x-access-token': data["token"],
      });
      log(all_psycs.body);
      Provider.of<All_Psychologists_Provider>(context, listen: false)
          .setPsycs(all_psycs.body);
      Provider.of<ClientProvider>(context, listen: false).setClient(data);
    }

    return jsonDecode(response.body);
  }
}
