// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/login/forgotpassScreenView.dart';

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
    const String logintext = "Giriş Yap";

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          BackButton(height: height, width: width),
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
                  forgotpasstext: forgotpasstext,
                  routeName: ForgotPassScreenView.routeName,
                ),
                SizedBox(height: height * 0.06),
                LoginButton(height: height, logintext: logintext),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.height,
    required this.logintext,
  }) : super(key: key);

  final double height;
  final String logintext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff46005F).withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {},
        child: Text(
          logintext,
          style: TextStyle(
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
    required this.forgotpasstext,
    required this.routeName,
  }) : super(key: key);

  final String forgotpasstext;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Text(
        forgotpasstext,
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
      child: TextFormField(
        controller: username,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: mailtext,
          contentPadding: EdgeInsets.only(
            left: width * 0.046,
            top: height * 0.006,
            right: width * 0.046,
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
      child: TextFormField(
        obscureText: !widget.passwordVisible,
        controller: widget.password,
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
            top: widget.height * 0.006,
            right: widget.width * 0.046,
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
