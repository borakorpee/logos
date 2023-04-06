// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logos/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'package:logos/screens/forgot_pass/email_OTP.dart';

class ClientProvider extends ChangeNotifier {
  ClientModel _client = ClientModel(
    status: null,
    message: '',
    token: '',
    client: null,
  );
  String? get get_token => _client.token;
  ClientModel get get_client => _client;

  Future<void> addFavorites(String id) async {
    _client.client!.favorites!.add(id);
    notifyListeners();
    var response = await http.put(Uri.parse("$root/client/favori"), body: {
      'id': _client.client!.sId,
      'favorites': id,
    }, headers: {
      'x-access-token': _client.token!,
    });
    var data = jsonDecode(response.body);
    print(data);
    print(_client.client!.favorites!);
  }

  Future<void> removeFavorites(String id) async {
    _client.client!.favorites!.remove(id);
    notifyListeners();
    var response =
        await http.put(Uri.parse("$root/client/favori/delete"), body: {
      'id': _client.client!.sId,
      'favorites': id,
    }, headers: {
      'x-access-token': _client.token!,
    });
    var data = jsonDecode(response.body);
    print(data);
    print(_client.client!.favorites!);
  }

  Future<void> updateClient({
    required String name,
    required String surname,
    required String il,
    required String ilce,
    required String email,
    required String meslek,
    required String password,
  }) async {
    _client.client!.name = name.isEmpty ? _client.client!.name : name;
    _client.client!.surName =
        surname.isEmpty ? _client.client!.surName : surname;
    _client.client!.city = il.isEmpty ? _client.client!.city : il;
    _client.client!.county = ilce.isEmpty ? _client.client!.county : ilce;
    _client.client!.eMail = email.isEmpty ? _client.client!.eMail : email;
    _client.client!.job = meslek.isEmpty ? _client.client!.job : meslek;
    _client.client!.pass = password.isEmpty ? _client.client!.pass : password;

    var response = await http.put(
      Uri.parse("$root/client/update/${_client.client!.sId}"),
      headers: {"x-access-token": _client.token!},
      body: {
        "name": _client.client!.name,
        "surName": _client.client!.surName,
        "city": _client.client!.city,
        "county": _client.client!.county,
        "eMail": _client.client!.eMail,
        "job": _client.client!.job,
        "pass": _client.client!.pass,
      },
    );
    var data = jsonDecode(response.body);
    print(data);
    notifyListeners();
  }

  void setClient(dynamic client) {
    _client = ClientModel.fromJson(client);

    notifyListeners();
  }
}
