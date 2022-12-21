import 'package:flutter/material.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client;
    return Scaffold(
      body: Column(children: <Widget>[]),
    );
  }
}
