import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/d.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/forgot_pass/forgotpassScreenView.dart';
import 'package:logos/screens/forgot_pass/newpassScreenView.dart';
import 'package:logos/screens/forgot_pass/otpScreenView.dart';
import 'package:logos/screens/forgot_pass/successScreenView.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/onboard/onboardScreenView.dart';
import 'package:logos/screens/register/kvkkScreenView.dart';
import 'package:logos/screens/register/registerScreen2View.dart';
import 'package:logos/screens/register/registerScreenView.dart';
import 'package:logos/screens/register/registerSuccessScreenView.dart';
import 'package:provider/provider.dart';
import 'screens/register/registerScreen3View.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ClientProvider(),
    )
  ], child: const MyApp()));
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
        OtpScreenView.routeName: (ctx) => const OtpScreenView(),
        NewPassScreen.routeName: (ctx) => const NewPassScreen(),
        SuccessScreenView.routeName: (ctx) => const SuccessScreenView(),
        RegisterScreenView.routeName: (ctx) => const RegisterScreenView(),
        RegisterScreen2.routeName: (ctx) => const RegisterScreen2(),
        RegisterScreen3.routeName: (ctx) => const RegisterScreen3(),
        RegisterSuccess.routeName: (ctx) => const RegisterSuccess(),
        KvkkScreen.routeName: (ctx) => const KvkkScreen(),
        dddd.routeName: (ctx) => const dddd(),
      },
    );
  }
}
