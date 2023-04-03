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

  void updateClient({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) {
    print("Updated");
    print(name);
    print(surname);
    print(email);
    print(password);
    _client.client!.name = name;
    _client.client!.surName = surname;
    _client.client!.eMail = email;
    _client.client!.pass = password;

    notifyListeners();
  }

  void setClient(dynamic client) {
    _client = ClientModel.fromJson(client);

    notifyListeners();
  }
}
