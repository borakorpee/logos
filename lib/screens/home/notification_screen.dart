import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logos/screens/home/new_home.dart';

import '../profile/profile_page.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/notification-screen";
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMMM y', 'tr_TR');
    String today = formatter.format(now);
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 75).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 27, right: 27).r,
                child: const CustomAppbar(appBarTitle: "Bildirimler"),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 40).r,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Bugün | $today",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 40).r,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Öncekiler",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                  const SingleNotification(),
                  const Divider(thickness: 1),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleNotification extends StatelessWidget {
  const SingleNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 20).r,
      child: SizedBox(
        width: 430.w,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 67.w,
                  height: 67.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffBC00FF).withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/home/Union.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(width: 22.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bugün saat 09.00'da Prof. Dr Ahmet Yılmaz ile\nrandevun var.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Şimdi Katıl",
                      style: TextStyle(
                        color: const Color(0xffBC00FF),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
