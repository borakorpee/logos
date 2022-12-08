import 'package:flutter/material.dart';
import 'package:logos/components/customBackButton.dart';

class ForgotPassScreenView extends StatelessWidget {
  static const routeName = "/forgotpass";

  const ForgotPassScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          CustomBackButton(context),
          Text("şifremi unuttum!"),
        ],
      )),
    );
  }
}
