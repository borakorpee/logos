// ignore_for_file: file_names, must_be_immutable, prefer_initializing_formals, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:logos/screens/forgot_pass/successScreenView.dart';
import 'package:logos/service/auth_service.dart';
import '../../components/customBackButton.dart';

class NewPassScreen extends StatefulWidget {
  static const routeName = "/new-pass";
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
  bool isPass_error = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(children: <Widget>[
          CustomBackButton(context),
          Padding(
            padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.062),
                Title(titletext: titletext),
                SizedBox(height: height * 0.026),
                Description(descriptiontext: descriptiontext),
                SizedBox(height: height * 0.026),
                PasswordTextField(
                  password_controler: password1,
                  passwordVisible: passwordVisible1,
                  passtext: passtext1,
                  isPass_error: isPass_error,
                  other_controller: password2,
                ),
                SizedBox(height: height * 0.016),
                PasswordTextField(
                  password_controler: password2,
                  passwordVisible: passwordVisible2,
                  passtext: passtext2,
                  isPass_error: isPass_error,
                  other_controller: password1,
                ),
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
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        AuthService.resetPass(args["token"], password2.text);

                        Navigator.of(context)
                            .popAndPushNamed(SuccessScreenView.routeName);
                      }
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
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.descriptiontext,
  }) : super(key: key);

  final String descriptiontext;

  @override
  Widget build(BuildContext context) {
    return Text(
      descriptiontext,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xff8391A1),
      ),
      textAlign: TextAlign.left,
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.titletext,
  }) : super(key: key);

  final String titletext;

  @override
  Widget build(BuildContext context) {
    return Text(
      titletext,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    required this.password_controler,
    required this.passwordVisible,
    required this.passtext,
    required this.isPass_error,
    required this.other_controller,
  }) : super(key: key);

  final TextEditingController password_controler;
  final TextEditingController other_controller;

  bool passwordVisible;
  final String passtext;
  bool isPass_error;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.password_controler,
      cursorColor: const Color(0xff46005F),
      obscureText: !widget.passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: widget.passwordVisible
              ? Image.asset("assets/login/passicon.png")
              : Image.asset("assets/login/Vector.png"),
          onPressed: () {
            setState(() {
              widget.passwordVisible = !widget.passwordVisible;
            });
          },
        ),
        contentPadding: const EdgeInsets.only(left: 20, top: 20),
        hintText: widget.passtext,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.isPass_error ? Colors.red : const Color(0xffDADADA),
          ),
        ),
        fillColor: widget.isPass_error
            ? const Color(0xffFF0000).withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.isPass_error ? Colors.red : const Color(0xffDADADA),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            widget.isPass_error = true;
          });
          return 'Bu alan boş bırakılamaz.';
        } else if (value != widget.other_controller.text) {
          setState(() {
            widget.isPass_error = true;
          });
          return "Girdiğiniz şifreler aynı olmalıdır";
        }
        setState(() {
          widget.isPass_error = false;
        });
        return null;
      },
    );
  }
}
