// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:logos/models/client_model.dart';
import 'package:provider/provider.dart';

class ClientProvider extends ChangeNotifier {
  ClientModel _client = ClientModel(
    status: null,
    message: '',
    token: '',
    client: null,
  );
  String? get get_token => _client.token;
  ClientModel get get_client => _client;

  void updateClient(
      String name, String surname, String email, String password) {
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
