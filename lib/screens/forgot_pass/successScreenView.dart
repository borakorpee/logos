// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SuccessScreenView extends StatelessWidget {
  static const routeName = "/pass-change-success";
  const SuccessScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    String buttontext = "Girişe geri dön";

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * 0.34),
              SizedBox(
                width: width * 0.2325,
                height: height * 0.11,
                child: Stack(
                  children: <Widget>[
                    Center(child: Image.asset("assets/forgot_pass/Vector.png")),
                    Center(
                      child: SizedBox(
                          width: width * 0.11,
                          height: height * 0.04,
                          child: Image.asset("assets/forgot_pass/tik.png")),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.032),
              const Text(
                "Şifre Güncellendi",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
              ),
              const Text(
                "Şifren başarılı bir şekilde \n güncellendi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: height * 0.037),
              Button(height: height, text: buttontext),
            ],
          ),
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
          Navigator.of(context).pop();
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
