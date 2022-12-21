import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logos/models/client_model.dart';

class ClientProvider extends ChangeNotifier {
  ClientModel _client = ClientModel(
    status: null,
    message: '',
    token: '',
    client: null,
  );

  ClientModel get get_client => _client;

  void setClient(dynamic client) {
    _client = ClientModel.fromJson(jsonDecode(client));

    notifyListeners();
  }
}
