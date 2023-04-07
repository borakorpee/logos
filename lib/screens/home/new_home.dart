import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/home/favorites_page.dart';
import 'package:logos/screens/profile/profile_page.dart';

import 'home_page.dart';

class NewHomePage extends StatelessWidget {
  static const routeName = "/new_home";
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: const Icon(Icons.ad_units),
            ),
          ),
        ],
      ),*/

      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 75).r,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/home/asd.png"),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(FavoritesPage.routeName);
                    },
                    child: Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(width: 7.w),
                  const DrawerButton(),
                ],
              ),
            ),
            SearchBar(),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              route: '/profile',
            ),
            const DrawerRow(
              drawerIconPath: 'assets/drawer/psikiyatristler.png',
              drawerTitle: 'Psikologlar',
              route: '/profile',
            ),
            const DrawerRow(
              drawerIconPath: 'assets/drawer/bildirimler.png',
              drawerTitle: 'Bildirimler',
              route: '/profile',
            ),
            const DrawerRow(
              drawerIconPath: 'assets/drawer/profil.png',
              drawerTitle: 'Profilim',
              route: '/profile',
            ),
            const DrawerRow(
              drawerIconPath: 'assets/drawer/mesajlar.png',
              drawerTitle: 'Mesajlar',
              route: '/profile',
            ),
            const DrawerRow(
              drawerIconPath: 'assets/drawer/ayarlar.png',
              drawerTitle: 'Ayarlar',
              route: '/profile',
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
    );
  }
}

class DrawerRow extends StatelessWidget {
  final String drawerTitle;
  final String drawerIconPath;
  final String route;
  const DrawerRow({
    Key? key,
    required this.drawerTitle,
    required this.drawerIconPath,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, route);
      },
      child: SizedBox(
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
      ),
    );
  }
}
