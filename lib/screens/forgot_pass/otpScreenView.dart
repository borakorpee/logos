// ignore_for_file: file_names, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class OtpScreenView extends StatefulWidget {
  static const routeName = "/otp";
  const OtpScreenView({super.key});

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  bool inputcolor1 = false;
  bool inputcolor2 = false;
  bool inputcolor3 = false;
  bool inputcolor4 = false;
  late int kod;

  final buttontext = "Kodu Onayla";
  final String bottomtext = "Şifreni hatırladın mı?";
  final String bottomlinktext = "Giriş yap";
  final String titletext = "Onaylama kodu";
  final String descriptiontext =
      "Lütfen hesabın ile bağlantılı olan mail adresine gelen kodu giriniz.";
  void generatecode() {
    var rng = new Random();
    var code = rng.nextInt(9000) + 1000;
    kod = code;
  }

  Future<bool> sendMail(
      String name, String email, int code, BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Mesaj Gönderiliyor...\nMessage Sending",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    }));
    bool sendStates = false;
    try {
      String _username = '';
      String _password = '';

      /*final smtpServer = SmtpServer('borakorpe3@gmail.com',
          username: _username,
          password: _password,
          ignoreBadCertificate: false,
          ssl: false,
          allowInsecure: true);*/

      final smtpServer = hotmail(_username, _password);

      String date = DateTime.now().toString();
      String sendmail = "borakorpe3@gmail.com";
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
    } finally {
      Navigator.pop(context);
    }
    return sendStates;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generatecode();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          sendMail("bora", "borakorpe3@gmail.com", kod, context);
        }),
        body: Column(
          children: <Widget>[
            CustomBackButton(context),
            Padding(
              padding:
                  EdgeInsets.only(left: width * 0.110, right: width * 0.110),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PinField(
                        height: height,
                        width: width,
                        inputcolor: inputcolor1,
                        pin: pin1,
                        isLast: false,
                        isfirst: true,
                      ),
                      PinField(
                        height: height,
                        width: width,
                        inputcolor: inputcolor2,
                        pin: pin2,
                        isLast: false,
                        isfirst: false,
                      ),
                      PinField(
                        height: height,
                        width: width,
                        inputcolor: inputcolor3,
                        pin: pin3,
                        isLast: false,
                        isfirst: false,
                      ),
                      PinField(
                        height: height,
                        width: width,
                        inputcolor: inputcolor4,
                        pin: pin4,
                        isLast: true,
                        isfirst: false,
                      ),
                    ],
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
                      onPressed: () {
                        var pin = pin1.text + pin2.text + pin3.text + pin4.text;
                        if (pin == kod.toString())
                          print("doğru");
                        else {
                          print("yanlış");
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
                  SizedBox(height: height * 0.445),
                  BottomText(
                      bottomtext: bottomtext,
                      width: width,
                      bottomlinktext: bottomlinktext),
                ],
              ),
            ),
          ],
        ));
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
            Navigator.popUntil(context, ModalRoute.withName('/login'));
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

class PinField extends StatefulWidget {
  PinField({
    Key? key,
    required this.height,
    required this.width,
    required this.inputcolor,
    required this.pin,
    required this.isfirst,
    required this.isLast,
  }) : super(key: key);

  final double height;
  final double width;
  bool inputcolor;
  final TextEditingController pin;
  final bool isfirst;
  final bool isLast;

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.06,
      width: widget.width * 0.12,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: widget.inputcolor
                ? const Color(0xffA800A4)
                : const Color(0xffE8ECF4),
          ),
          color: Colors.black.withOpacity(0.05)),
      child: Center(
        child: TextFormField(
          controller: widget.pin,
          onChanged: ((value) {
            if (value == "") {
              widget.isfirst ? null : FocusScope.of(context).previousFocus();
              setState(() {
                widget.inputcolor = false;
              });
            } else if (value != "") {
              widget.isLast ? null : FocusScope.of(context).nextFocus();

              setState(() {
                widget.inputcolor = true;
              });
            }
          }),
          decoration: const InputDecoration(border: InputBorder.none),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
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
          ;
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
