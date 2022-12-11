import 'package:flutter/material.dart';

import '../../components/customBackButton.dart';

class NewPassScreen extends StatefulWidget {
  static const routeName = "/new-pass";
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        CustomBackButton(context),
      ]),
    );
  }
}
