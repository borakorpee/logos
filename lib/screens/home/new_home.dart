import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/screens/home/favorites_page.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../psyc_profile/psycs_profileScreenView.dart';

class NewHomePage extends StatelessWidget {
  static const routeName = "/new_home";
  const NewHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final psyc = Provider.of<All_Psychologists_Provider>(context).psyc_list!;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 75).r,
        child: Column(
          children: [
            const HomeAppbar(),
            SizedBox(height: 15.h),
            const SearchBar(),
            SizedBox(height: 15.h),
            const HorizontalList(),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                RouteButtons(
                  buttonIconPath: 'assets/home/asd.svg',
                  buttonText: 'Psikologlar',
                ),
                RouteButtons(
                  buttonIconPath: 'assets/home/svg2.svg',
                  buttonText: 'Randevularım',
                ),
                RouteButtons(
                  buttonIconPath: 'assets/home/svg3.svg',
                  buttonText: 'Görüş',
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 35)
                          .r,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "En İyi Psikologlar",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 220.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 35, top: 5).r,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PsycsScreenView.routeName,
                                arguments: {"id": psyc[index].sId});
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 170.w,
                                height: 210.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 170.w,
                                      height: 110.h,
                                    ),
                                    const SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                                left: 15, right: 15)
                                            .r,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${psyc[index].unvan} ${psyc[index].name} ${psyc[index].surName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: Colors.black
                                                    .withOpacity(0.75),
                                              ),
                                            ),
                                            Text(
                                              psyc[index].tag![0],
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.35),
                                                  fontSize: 7.sp),
                                            ),
                                            SizedBox(height: 7.h),
                                            Row(
                                              children: [
                                                const StarIcon(),
                                                Text(
                                                  "  4.6 (1620 Oylama)",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 6.sp,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: 10.w,
                                                  height: 10.h,
                                                  child: SvgPicture.asset(
                                                      "assets/psyc_profile/tecrube.svg"),
                                                ),
                                                Text(
                                                  "  5+ Tecrübe",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 6.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "249.90 ₺",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "Seans başı",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: 6.sp,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: 170.w,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/home/psyc_pic${index + 1}.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RouteButtons extends StatelessWidget {
  final String buttonText;
  final String buttonIconPath;
  const RouteButtons({
    Key? key,
    required this.buttonText,
    required this.buttonIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          FittedBox(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
              child: Row(
                children: [
                  SvgPicture.asset(buttonIconPath),
                  SizedBox(width: 5.w),
                  Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController(initialScrollOffset: 325.w);
    final List HorizontalListEntries = [
      "Bir Sonraki Randevunuzu\nÇevrimiçi Olarak Ayırtın!",
      "İhtiyaçlarınız İçin\ndoğru doktoru bulun",
      "Özel Seçilen Psikologlar ile\nGörüşme İmkanı Elde Edin!"
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).r,
      child: SizedBox(
        width: double.infinity,
        height: 175.h,
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16).r,
              child: Container(
                width: 340.w,
                height: 175.h,
                decoration: BoxDecoration(
                    color: const Color(0xff6B337F),
                    borderRadius: BorderRadius.circular(11)),
                child: Stack(
                  children: [
                    Positioned(
                      right: index == 0 ? -20 : -2,
                      bottom: -2,
                      child: Image.asset(
                        "assets/home/pic${index + 1}.png",
                        scale: 1.04,
                      ),
                    ),
                    const Positioned(
                      top: -25,
                      left: -25,
                      child: backgroundCircle(
                        circleHeight: 115,
                        circleWidth: 115,
                      ),
                    ),
                    const Positioned(
                      top: -30,
                      right: -50,
                      child: backgroundCircle(
                        circleHeight: 175,
                        circleWidth: 175,
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 35).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                HorizontalListEntries[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Şimdi randevu alın ve özel indirimlerden\nfaydalanın.",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              GestureDetector(
                                onTap: () {
                                  print("Doktor ara ekranı");
                                },
                                child: Container(
                                  width: 125.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffBC00FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20.w),
                                        Text(
                                          "Randevu Al",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class backgroundCircle extends StatelessWidget {
  final double circleWidth;
  final double circleHeight;

  const backgroundCircle({
    Key? key,
    required this.circleWidth,
    required this.circleHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleWidth.w,
      height: circleHeight.h,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9).withOpacity(0.05),
        shape: BoxShape.circle,
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10).r,
            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 57.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home/yeniLogoSiyah 2.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 57.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home/yeniLogoSiyah 3.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FavoritesPage.routeName);
            },
            child: Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
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
        padding: const EdgeInsets.only(left: 55, top: 87, bottom: 30).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 41.h),
            Row(
              children: [
                SizedBox(
                  width: 55.w,
                  height: 55.h,
                  child: Image.asset(
                    "assets/home/yeniLogoSiyah 2.png",
                  ),
                ),
                SizedBox(
                  width: 120.w,
                  height: 55.h,
                  child: Image.asset(
                    "assets/home/yeniLogoSiyah 3.png",
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 13).r,
                child: Column(
                  children: [
                    const DrawerRow(
                      drawerIconPath: 'assets/drawer/anasayfa.png',
                      drawerTitle: 'Anasayfa',
                      route: '/new_home',
                    ),
                    const DrawerRow(
                      drawerIconPath: 'assets/drawer/psikiyatristler.png',
                      drawerTitle: 'Psikologlar',
                      route: '/psyc_search',
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
                                fontSize: 18.sp,
                                color: const Color(0xff6D6C6C)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36).r,
      child: SizedBox(
        height: 35.h,
        child: TextFormField(
          onTap: (() {}),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0.7.w,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0.7.w,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            hintText: "Psikiyatri Doktoru Ara...",
            hintStyle: TextStyle(
              fontSize: 12.h,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: IconButton(
              onPressed: null,
              icon: SvgPicture.asset("assets/home/search.svg"),
              iconSize: 20.w,
            ),
          ),
        ),
      ),
    );
  }
}
