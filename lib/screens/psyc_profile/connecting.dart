import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/psyc_profile/vide_call.dart';

class ConnectingToPsyc extends StatefulWidget {
  static const routeName = "/connectingto-psyc";
  const ConnectingToPsyc({super.key});

  @override
  State<ConnectingToPsyc> createState() => _ConnectingToPsycState();
}

class _ConnectingToPsycState extends State<ConnectingToPsyc> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      final args = ModalRoute.of(context)?.settings.arguments
          as Map<String, Psychologists>;
      ;
      Navigator.pushReplacementNamed(context, VideCall.routeName, arguments: {
        "provider": args["provider"],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, Psychologists>;
    Psychologists? psyc = args["provider"];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("$imgroot/uploads/${psyc!.image}"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 105).r,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50).r,
                      child: Row(
                        children: [
                          Container(
                            width: 66.w,
                            height: 66.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$imgroot/uploads/${psyc.image}"),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${psyc.unvan} ${psyc.name} ${psyc.surName}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Bağlanılıyor...",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white.withOpacity(0.66),
                                  fontSize: 15.sp,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
