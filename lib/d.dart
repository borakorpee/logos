// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/models/client_model.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:provider/provider.dart';

class dddd extends StatefulWidget {
  static const routeName = "/tes";
  const dddd({super.key});

  @override
  State<dddd> createState() => _ddddState();
}

class _ddddState extends State<dddd> {
  bool iserr = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final client = Provider.of<ClientProvider>(context).get_client.client;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
