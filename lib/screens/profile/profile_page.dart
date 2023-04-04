import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/new_home.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7).r,
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Profilim",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Builder(
                        builder: (ctx) => IconButton(
                          onPressed: () {
                            Scaffold.of(ctx).openDrawer();
                          },
                          icon: const Icon(Icons.ad_units),
                        ),
                      );
                    },
                    child: Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/drawer/t.png"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 43.h),
            Stack(
              children: [
                Container(
                  width: 374.w,
                  height: 192.h,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Color(0xff6B337F),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
