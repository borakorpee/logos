// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:logos/screens/forgot_pass/otpScreenView.dart';

Widget CustomBigButton(BuildContext context, String text) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return SizedBox(
    width: double.infinity,
    height: height * 0.06,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff46005F).withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
