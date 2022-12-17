// ignore_for_file: file_names, must_be_immutable, prefer_initializing_formals, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:logos/d.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/forgot_pass/forgotpassScreenView.dart';
import 'package:logos/screens/register/registerScreenView.dart';
import 'package:http/http.dart' as http;

class LoginScreenView extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final String maintext = "Hoş Geldin!";
  final String mailtext = "Mail adresi";
  final String passtext = "Şifre";
  final String forgotpasstext = "Şifremi unuttum";
  final String registertext = "Kayıt ol";
  final String registerasktext = "Hesabın yok mu?";
  final String logintext = "Giriş Yap";

  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isMail_error = false;
  bool isPass_error = false;
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: height * 0.033,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    registerasktext,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: width * 0.023),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RegisterScreenView.routeName);
                    },
                    child: Text(
                      registertext,
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  CustomBackButton(context),
                  SizedBox(height: height * 0.044),
                  Logo(width: width, height: height),
                  WelcomeText(text: maintext),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.032, horizontal: width * 0.11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          controller: mail,
                          cursorColor: const Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 20),
                            hintText: mailtext,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isMail_error
                                    ? Colors.red
                                    : const Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isMail_error
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
                                isMail_error = true;
                              });
                              return 'Bu alan boş bırakılamaz.';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Lüften geçerli bir mail adresi giriniz. ";
                            }
                            setState(() {
                              isMail_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.016),
                        TextFormField(
                          controller: password,
                          cursorColor: const Color(0xff46005F),
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: passwordVisible
                                  ? Image.asset("assets/login/passicon.png")
                                  : Image.asset("assets/login/Vector.png"),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 20),
                            hintText: passtext,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isPass_error
                                    ? Colors.red
                                    : const Color(0xffDADADA),
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
                            }
                            setState(() {
                              isPass_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.021),
                        LinkText(
                          text: forgotpasstext,
                          routeName: ForgotPassScreenView.routeName,
                        ),
                        SizedBox(height: height * 0.06),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xff46005F).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                var response = await http.post(
                                    Uri.parse(
                                      root + "client/login",
                                    ),
                                    body: {
                                      'email': mail.text,
                                      'pass': password.text,
                                    });
                                var data = jsonDecode(response.body);
                                print(data);
                                if (data["status"] == true) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              dddd()),
                                      ModalRoute.withName(dddd.routeName));
                                }
                              } else {}
                            },
                            child: Text(
                              logintext,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.height,
    required this.logintext,
    required this.us,
    required this.pas,
  }) : super(key: key);

  final double height;
  final String logintext;
  final TextEditingController us;
  final TextEditingController pas;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff46005F).withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const dddd()),
              ModalRoute.withName(dddd.routeName));
        },
        child: Text(
          logintext,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  const LinkText({
    Key? key,
    required this.text,
    required this.routeName,
  }) : super(key: key);

  final String text;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Text(
        text,
        style: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class MailTextField extends StatelessWidget {
  const MailTextField({
    Key? key,
    required this.height,
    required this.username,
    required this.mailtext,
    required this.width,
  }) : super(key: key);

  final double height;
  final TextEditingController username;
  final String mailtext;
  final double width;

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
      height: height * 0.06,
      child: Center(
        child: TextFormField(
          controller: username,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: mailtext,
            contentPadding: EdgeInsets.only(
              left: width * 0.046,
              bottom: height * 0.012,
              right: width * 0.046,
            ),
          ),
        ),
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
                    : Image.asset("assets/login/Vector.png")),
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

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.7),
      ),
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
