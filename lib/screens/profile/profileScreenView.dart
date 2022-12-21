import 'package:flutter/material.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreenView extends StatelessWidget {
  static const routeName = "/profile";

  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(client?.name ?? ""),
              Text(client?.surName ?? ""),
              Text(client?.eMail ?? ""),
              Text(client?.dateOfBirth ?? ""),
              Text(client?.job ?? ""),
              Text(client?.sex ?? ""),
              Text(client?.city ?? ""),
              Text(client?.county ?? ""),
              Text(client?.sId ?? ""),
              SizedBox(height: 10),
              Text(client?.toJson().toString() ?? ""),
            ]),
      ),
    );
  }
}
