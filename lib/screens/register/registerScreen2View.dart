import 'package:flutter/material.dart';

import '../../components/customBackButton.dart';

class RegisterScreen2 extends StatefulWidget {
  static const routeName = "/register2";
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Column(children: <Widget>[
        CustomBackButton(context),
        Padding(
          padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
          child: Column(
            children: [
              SizedBox(height: height * 0.044),
              Logo(width: width, height: height),
              Text(
                "Kayıt Ol",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Text(args["identity"]),
              Text(args["username"]),
              Text(args["sex"]),
              Text(args["job"]),
              Text(args["city"]),
              Text(args["county"]),
            ],
          ),
        ),
      ]),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.17,
      height: height * 0.103,
      child: Image.asset("assets/login/headlogo.png"),
    );
  }
}
