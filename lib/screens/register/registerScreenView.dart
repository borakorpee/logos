import 'package:flutter/material.dart';
import '../../components/customBackButton.dart';

class RegisterScreenView extends StatelessWidget {
  static const routeName = "/register";

  const RegisterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          CustomBackButton(context),
          Text("Kayıt ol"),
        ],
      )),
    );
  }
}
