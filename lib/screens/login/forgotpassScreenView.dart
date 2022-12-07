import 'package:flutter/material.dart';

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
          BackButton(height: height, width: width),
          Text("şifremi unuttum!"),
        ],
      )),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.08, left: width * 0.07),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
          ),
        ],
      ),
    );
  }
}
