// ignore_for_file: file_names, must_be_immutable, prefer_initializing_formals, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:logos/d.dart';
import 'package:logos/screens/forgot_pass/forgotpassScreenView.dart';
import 'package:logos/screens/register/registerScreenView.dart';

class LoginScreenView extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    const String maintext = "Hoş Geldin!";
    const String mailtext = "Mail adresi";
    const String passtext = "Şifre";
    const String forgotpasstext = "Şifremi unuttum";
    const String registertext = "Kayıt ol";
    const String registerasktext = "Hesabın yok mu?";

    const String logintext = "Giriş Yap";

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
            Column(
              children: <Widget>[
                CustomBackButton(context),
                SizedBox(height: height * 0.044),
                Logo(width: width, height: height),
                const WelcomeText(text: maintext),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.032, horizontal: width * 0.11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      MailTextField(
                          height: height,
                          username: username,
                          mailtext: mailtext,
                          width: width),
                      SizedBox(height: height * 0.016),
                      PasswordTextField(
                          passwordVisible: passwordVisible,
                          password: password,
                          passtext: passtext,
                          width: width,
                          height: height),
                      SizedBox(height: height * 0.021),
                      const LinkText(
                        text: forgotpasstext,
                        routeName: ForgotPassScreenView.routeName,
                      ),
                      SizedBox(height: height * 0.06),
                      LoginButton(
                        height: height,
                        logintext: logintext,
                        pas: password,
                        us: username,
                      ),
                    ],
                  ),
                )
              ],
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
              MaterialPageRoute(builder: (BuildContext context) => dddd()),
              ModalRoute.withName(dddd.routeName));
          print(us.text);
          print(pas.text);
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
