// ignore_for_file: file_names, must_be_immutable, prefer_initializing_formals, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/forgot_pass/successScreenView.dart';
import 'package:http/http.dart' as http;
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
                TextFormField(
                  controller: password1,
                  cursorColor: const Color(0xff46005F),
                  obscureText: !passwordVisible1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: passwordVisible1
                          ? Image.asset("assets/login/passicon.png")
                          : Image.asset("assets/login/Vector.png"),
                      onPressed: () {
                        setState(() {
                          passwordVisible1 = !passwordVisible1;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    hintText: passtext1,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:
                            isPass_error ? Colors.red : const Color(0xffDADADA),
                      ),
                    ),
                    fillColor: isPass_error
                        ? const Color(0xffFF0000).withOpacity(0.05)
                        : Colors.black.withOpacity(0.05),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffDADADA),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        isPass_error = true;
                      });
                      return 'Bu alan boş bırakılamaz.';
                    } else if (value != password2.text) {
                      setState(() {
                        isPass_error = true;
                      });
                      return "Girdiğiniz şifreler aynı olmalıdır";
                    }
                    setState(() {
                      isPass_error = false;
                    });
                    return null;
                  },
                ),
                SizedBox(height: height * 0.016),
                TextFormField(
                  controller: password2,
                  cursorColor: const Color(0xff46005F),
                  obscureText: !passwordVisible2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: passwordVisible2
                          ? Image.asset("assets/login/passicon.png")
                          : Image.asset("assets/login/Vector.png"),
                      onPressed: () {
                        setState(() {
                          passwordVisible2 = !passwordVisible2;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    hintText: passtext2,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color:
                            isPass_error ? Colors.red : const Color(0xffDADADA),
                      ),
                    ),
                    fillColor: isPass_error
                        ? const Color(0xffFF0000).withOpacity(0.05)
                        : Colors.black.withOpacity(0.05),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffDADADA),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        isPass_error = true;
                      });
                      return 'Bu alan boş bırakılamaz.';
                    } else if (value != password1.text) {
                      setState(() {
                        isPass_error = true;
                      });
                      return "Girdiğiniz şifreler aynı olmalıdır";
                    }
                    setState(() {
                      isPass_error = false;
                    });
                    return null;
                  },
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

                        /* var response = await http
                            .put(Uri.parse("$root/client/reset/pass"), body: {
                          "token": args["token"],
                          "pass": password2.text,
                        });*/

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
