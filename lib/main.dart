import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/login/forgotpassScreenView.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/onboard/onboardScreenView.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const OnboardScreenView(),
      routes: {
        LoginScreenView.routeName: (ctx) => const LoginScreenView(),
        ForgotPassScreenView.routeName: (ctx) => const ForgotPassScreenView(),
      },
    );
  }
}
