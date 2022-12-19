// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/components/customBackButton.dart';
import 'package:logos/screens/forgot_pass/newpassScreenView.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  late String pin;
  final String buttontext = "Kodu Onayla";
  final String bottomtext = "Şifreni hatırladın mı?";
  final String bottomlinktext = "Giriş yap";
  final String titletext = "Onaylama kodu";
  final String descriptiontext =
      "Lütfen hesabın ile bağlantılı olan mail adresine gelen kodu giriniz.";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: height * 0.033,
              child: BottomText(
                  bottomtext: bottomtext,
                  width: width,
                  bottomlinktext: bottomlinktext),
            ),
            Column(
              children: <Widget>[
                CustomBackButton(context),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.110, right: width * 0.110),
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
                      SizedBox(height: height * 0.04),
                      PinCodeTextField(
                        appContext: context,
                        length: 4,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          fieldWidth: width / 8,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.black.withOpacity(0.05),
                          selectedColor: Colors.black.withOpacity(0.05),
                          inactiveFillColor: Colors.black.withOpacity(0.05),
                          inactiveColor: Colors.black.withOpacity(0.05),
                          activeColor: const Color(0xffA800A4),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onChanged: ((value) {
                          pin = value;
                        }),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(height: height * 0.020),
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
                            if (args["otp_code"].toString() == pin) {
                              Navigator.of(context).popAndPushNamed(
                                  NewPassScreen.routeName,
                                  arguments: {
                                    'token': args["token"],
                                    'email': args["email"],
                                  });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Yanlış yada eksik kod!"),
                              ));
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
                      SizedBox(height: height * 0.021),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "Mail ulaşmadıysa",
                            style: TextStyle(
                              color: Color(0xff8391A1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            " spam",
                            style: TextStyle(
                              color: Color(0xff8391A1),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            " kutunuz kontrol ediniz.",
                            style: TextStyle(
                              color: Color(0xff8391A1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
        onPressed: () {},
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
