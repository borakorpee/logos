// ignore_for_file: file_names, must_be_immutable, prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:logos/screens/forgot_pass/successScreenView.dart';

import '../../components/customBackButton.dart';

class NewPassScreen extends StatefulWidget {
  static const routeName = "/new-pass";
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final String titletext = "Yeni parola oluştur";
  final String descriptiontext =
      "Yeni oluşturacağın parola eski paroladan farklı olmalı.";
  final String buttontext = "Şifreyi Yenile";

  final String passtext1 = "Yeni şifre";
  bool passwordVisible1 = false;
  TextEditingController password1 = TextEditingController();

  final String passtext2 = "Yeni şifre tekrarı";
  bool passwordVisible2 = false;
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: <Widget>[
        CustomBackButton(context),
        Padding(
          padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * 0.062),
              Text(
                titletext,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              SizedBox(height: height * 0.026),
              Text(
                descriptiontext,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff8391A1),
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: height * 0.026),
              PasswordTextField(
                  passwordVisible: passwordVisible1,
                  password: password1,
                  passtext: passtext1,
                  width: width,
                  height: height),
              SizedBox(height: height * 0.016),
              PasswordTextField(
                  passwordVisible: passwordVisible2,
                  password: password2,
                  passtext: passtext2,
                  width: width,
                  height: height),
              SizedBox(height: height * 0.032),
              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff46005F).withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(SuccessScreenView.routeName);
                  },
                  child: Text(
                    buttontext,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    required bool passwordVisible,
    required this.password,
    required this.passtext,
    required this.width,
    required this.height,
  })  : passwordVisible = passwordVisible,
        super(key: key);

  bool passwordVisible;
  final TextEditingController password;
  final String passtext;
  final double width;
  final double height;

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.05),
        border: Border.all(
          color: const Color(0xffDADADA),
          width: 1,
        ),
      ),
      height: widget.height * 0.06,
      child: Center(
        child: TextFormField(
          obscureText: !widget.passwordVisible,
          controller: widget.password,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.passwordVisible = !widget.passwordVisible;
                  });
                },
                child: widget.passwordVisible
                    ? Image.asset("assets/login/passicon.png")
                    : const Icon(Icons.visibility_off)),
            hintText: widget.passtext,
            contentPadding: EdgeInsets.only(
              left: widget.width * 0.046,
              bottom: widget.height * 0.015,
              right: widget.width * 0.046,
            ),
          ),
        ),
      ),
    );
  }
}
