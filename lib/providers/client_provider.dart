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

  ClientModel get get_client => _client;

  void updateClient() {
    _client.client!.name = "BORAAA";
    notifyListeners();
  }

  void setClient(dynamic client) {
    _client = ClientModel.fromJson(client);

    notifyListeners();
  }
}
