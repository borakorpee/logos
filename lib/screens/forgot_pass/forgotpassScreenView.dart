// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings, avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/forgot_pass/otpScreenView.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class ForgotPassScreenView extends StatefulWidget {
  static const routeName = "/forgotpass";

  const ForgotPassScreenView({super.key});

  @override
  State<ForgotPassScreenView> createState() => _ForgotPassScreenViewState();
}

class _ForgotPassScreenViewState extends State<ForgotPassScreenView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isMail_error = false;

  late int kod;
  final String titletext = "Şifreni mi unuttun?";
  final String mailtext = "Mail adresi";
  final String buttontext = "Kodu Gönder";
  final String descriptiontext =
      "Endişelenme!  Lütfen hesabın ile bağlantılı olan mailn adresini gir.";
  final String bottomtext = "Şifreni hatırladın mı?";
  final String bottomlinktext = "Giriş yap";

  TextEditingController mail = TextEditingController();
  void generatecode() {
    var rng = Random();
    var code = rng.nextInt(8999) + 1000;

    kod = code;
    print(kod.toString());
  }

  @override
  void initState() {
    generatecode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: height * 0.033,
          child: BottomText(
              bottomtext: bottomtext,
              width: width,
              bottomlinktext: bottomlinktext),
        ),
        Form(
          key: _key,
          child: Center(
              child: Column(
            children: <Widget>[
              CustomBackButton(context),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.110, right: width * 0.110),
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
                    Text(
                      descriptiontext,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff8391A1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height * 0.026),
                    TextFormField(
                      controller: mail,
                      cursorColor: Color(0xff46005F),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: mailtext,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color:
                                isMail_error ? Colors.red : Color(0xffDADADA),
                          ),
                        ),
                        fillColor: isMail_error
                            ? Color(0xffFF0000).withOpacity(0.05)
                            : Colors.black.withOpacity(0.05),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
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
                    SizedBox(height: height * 0.030),
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
                          var response = await http.get(Uri.parse(
                              root + "client/reset?email=${mail.text}"));
                          var data = jsonDecode(response.body);
                          var token = data["token"];

                          if (_key.currentState!.validate()) {
                            if (data["status"]) {
                              sendMail(mail.text, kod, context);
                              Navigator.of(context).popAndPushNamed(
                                  OtpScreenView.routeName,
                                  arguments: {
                                    'otp_code': kod,
                                    'token': token,
                                    'email': mail.text,
                                  });
                            }
                            if (!data["status"]) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Girdiğiniz mail bulunamadı.")));
                              setState(() {
                                isMail_error = true;
                              });
                            }
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
            ],
          )),
        ),
      ],
    ));
  }

  Future<bool> sendMail(String email, int code, BuildContext context) async {
    bool sendStates = false;
    try {
      String _username = mailusername;
      String _password = mailpassword;

      final smtpServer = hotmail(_username, _password);

      String date = DateTime.now().toString();
      String sendmail = email;
      String konu = "Şifre Sıfırlama Kodunuz";
      String mesajIcerigi = "Date/Tarih: $date \nMesage/Mesaj: $code";

      // Create our message.
      final message = Message()
        ..from = Address("$_username")
        ..recipients.add('$sendmail')
        ..subject = konu
        ..text = mesajIcerigi;

      try {
        final sendReport = await send(message, smtpServer);
        sendStates = true;
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        sendStates = false;
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    } catch (Exception) {
      print(Exception.toString());
    }
    return sendStates;
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
    required this.kod,
    required this.mailcontroller,
  }) : super(key: key);
  final double height;
  final String text;
  final int kod;
  final TextEditingController mailcontroller;

  Future<bool> sendMail(String email, int code, BuildContext context) async {
    bool sendStates = false;
    try {
      String _username = mailusername;
      String _password = mailpassword;

      final smtpServer = hotmail(_username, _password);

      String date = DateTime.now().toString();
      String sendmail = email;
      String konu = "Şifre Sıfırlama Kodunuz";
      String mesajIcerigi = "Date/Tarih: $date \nMesage/Mesaj: $code";

      // Create our message.
      final message = Message()
        ..from = Address("$_username")
        ..recipients.add('$sendmail')
        ..subject = konu
        ..text = mesajIcerigi;

      try {
        final sendReport = await send(message, smtpServer);
        sendStates = true;
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        sendStates = false;
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    } catch (Exception) {
      print(Exception.toString());
    }
    return sendStates;
  }

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
          sendMail(mailcontroller.text, kod, context);
          Navigator.of(context).popAndPushNamed(OtpScreenView.routeName,
              arguments: {'otp_code': kod});
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
