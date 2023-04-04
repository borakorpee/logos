import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomePage extends StatelessWidget {
  static const routeName = "/new_home";
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Builder(
              builder: (ctx) => IconButton(
                  onPressed: () {
                    Scaffold.of(ctx).openDrawer();
                  },
                  icon: const Icon(Icons.ad_units))),
        ],
      ),
      drawer: Drawer(
        width: 381.w,
        child: Padding(
          padding: const EdgeInsets.only(left: 65, top: 67, bottom: 30).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 145.w,
                height: 73.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home/logoBlack 2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 37.h),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/anasayfa.png',
                drawerTitle: 'Anasayfa',
              ),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/psikiyatristler.png',
                drawerTitle: 'Psikiyatristler',
              ),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/bildirimler.png',
                drawerTitle: 'Bildirimler',
              ),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/profil.png',
                drawerTitle: 'Profilim',
              ),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/mesajlar.png',
                drawerTitle: 'Mesajlar',
              ),
              const DrawerRow(
                drawerIconPath: 'assets/drawer/ayarlar.png',
                drawerTitle: 'Ayarlar',
              ),
              const Spacer(),
              SizedBox(
                width: 381.w,
                height: 75.h,
                child: Row(
                  children: [
                    SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: Image.asset(
                          "assets/drawer/yardım.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(width: 25.w),
                    Text(
                      'Yardım',
                      style: GoogleFonts.karla(
                          fontSize: 18.sp, color: const Color(0xff6D6C6C)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerRow extends StatelessWidget {
  final String drawerTitle;
  final String drawerIconPath;

  const DrawerRow({
    Key? key,
    required this.drawerTitle,
    required this.drawerIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 381.w,
      height: 75.h,
      child: Row(
        children: [
          SizedBox(
              width: 25.w,
              height: 25.h,
              child: Image.asset(
                drawerIconPath,
                fit: BoxFit.contain,
              )),
          SizedBox(width: 25.w),
          Text(
            drawerTitle,
            style: TextStyle(fontSize: 18.sp, color: const Color(0xff6D6C6C)),
          ),
        ],
      ),
    );
  }
}
