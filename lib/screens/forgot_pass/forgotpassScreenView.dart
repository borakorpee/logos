import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:logos/screens/forgot_pass/otpScreenView.dart';
import 'package:logos/screens/login/loginScreenView.dart';

class ForgotPassScreenView extends StatelessWidget {
  static const routeName = "/forgotpass";

  const ForgotPassScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    const String titletext = "Şifreni mi unuttun?";
    const String mailtext = "Mail adresi";
    const String buttontext = "Kodu Gönder";
    const String descriptiontext =
        "Endişelenme!  Lütfen hesabın ile bağlantılı olan mailn adresini gir.";
    const String bottomtext = "Şifreni hatırladın mı?";
    const String bottomlinktext = "Giriş yap";

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController mail = TextEditingController();
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          CustomBackButton(context),
          Padding(
            padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Text(
                  descriptiontext,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff8391A1),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: height * 0.026),
                MailTextField(
                  height: height,
                  username: mail,
                  mailtext: mailtext,
                  width: width,
                ),
                SizedBox(height: height * 0.030),
                Button(height: height, text: buttontext),
                SizedBox(height: height * 0.445),
                BottomText(
                    bottomtext: bottomtext,
                    width: width,
                    bottomlinktext: bottomlinktext),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
    required this.bottomtext,
    required this.width,
    required this.bottomlinktext,
  }) : super(key: key);

  final String bottomtext;
  final double width;
  final String bottomlinktext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          bottomtext,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black.withOpacity(0.6),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: width * 0.023),
        InkWell(
          onTap: () {
            Navigator.of(context).pop(LoginScreenView.routeName);
          },
          child: Text(
            bottomlinktext,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.height,
    required this.text,
  }) : super(key: key);

  final double height;
  final String text;

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
          Navigator.of(context).pushNamed(OtpScreenView.routeName);
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
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
