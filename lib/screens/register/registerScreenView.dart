// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../components/customBackButton.dart';

class RegisterScreenView extends StatefulWidget {
  static const routeName = "/register";

  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final String titletext = "Kayıt olmak için gerekli \n bilgileri giriniz.";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          CustomBackButton(context),
          Padding(
            padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
            child: Column(
              children: [
                SizedBox(height: height * 0.062),
                Text(
                  titletext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
