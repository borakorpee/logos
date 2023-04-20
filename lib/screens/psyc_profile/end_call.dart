import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/screens/psyc_profile/after_call_comment.dart';

class AfterCallScreen extends StatelessWidget {
  static const routeName = "/after_call";
  const AfterCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Psychologists? psyc = args["provider"];
    DateTime start = args["starttime"];
    DateTime end = args["endtime"];
    Duration difference = end.difference(start);
    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds.remainder(60);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Column(
              children: [
                Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.mecgale.com/wp-content/uploads/2017/08/dummy-profile.png"))),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Arama Sonlandı',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xffF0735A),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  '$minutes dakika  $seconds saniye',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(
                        AfterCallComment.routeName,
                        arguments: {
                          "provider": psyc,
                        });
                  },
                  child: Container(
                    width: 350.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffA950C9).withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Değerlendirme Ekleyin",
                        style: TextStyle(
                          color: const Color(0xffA950C9),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 350.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffA950C9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Anasayfa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
