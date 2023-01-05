import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var types = [
    "Hepsi",
    "psikolog",
    "ergen psikoloğu",
    "klinik psikoloğu",
    "cinsel_terapist",
    "çift terapsiti",
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<All_Psychologists_Provider>(context);
    final page = ModalRoute.of(context);
    page!.didPush().then((x) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              toolbarHeight: 90.h,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: const [
                  Appbar(),
                  SearchBar(),
                ],
              )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CustomCard(),
                  SizedBox(height: 17.h),
                  _HorizontalFiltersState(types: types, provider: provider),
                  SizedBox(height: 29.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36).r,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tercih Edilen Psikologlar",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.h,
                            color: Colors.black.withOpacity(0.75)),
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h),
                  HorizontalList(provider: provider),
                  SizedBox(height: 27.h),
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: _HeaderSliver(),
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: _filters.contains("Hepsi")
                  ? provider.psyc_list!.length
                  : provider.filtered_list.length,
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 36, right: 36, top: 10).r,
                  child: _filters.contains("Hepsi")
                      ? SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFB6C6D4),
                                  blurRadius: 40,
                                  offset: Offset(0, 40),
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  blurRadius: 40,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13, top: 20).r,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.25),
                                        child: Image.asset(
                                            "assets/snackbar/grey.png"),
                                      ),
                                      SizedBox(width: 12.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            provider.psyc_list![index].name
                                                    .toString() +
                                                " " +
                                                provider
                                                    .psyc_list![index].surName
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 15.w,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            provider.psyc_list![index].tag![0],
                                            style: TextStyle(
                                              fontSize: 12.w,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 115.w,
                                                height: 16.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 2, left: 14)
                                                          .r,
                                                  child: Text(
                                                    "50+ başarılı görüşme",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 8.w,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Container(
                                                width: 73.w,
                                                height: 16.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 2, left: 14)
                                                          .r,
                                                  child: Text(
                                                    "500₺/Saat",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8.w,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18.h),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFB6C6D4),
                                  blurRadius: 40,
                                  offset: Offset(0, 40),
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  blurRadius: 40,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13, top: 20).r,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.25),
                                        child: Image.asset(
                                            "assets/snackbar/grey.png"),
                                      ),
                                      SizedBox(width: 12.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            provider.filtered_list[index].name
                                                    .toString() +
                                                " " +
                                                provider.filtered_list[index]
                                                    .surName
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 15.w,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            provider
                                                .filtered_list[index].tag![0],
                                            style: TextStyle(
                                              fontSize: 12.w,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 115.w,
                                                height: 16.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 2, left: 14)
                                                          .r,
                                                  child: Text(
                                                    "50+ başarılı görüşme",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 8.w,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Container(
                                                width: 73.w,
                                                height: 16.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 2, left: 14)
                                                          .r,
                                                  child: Text(
                                                    "500₺/Saat",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8.w,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18.h),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36).r,
      width: double.infinity,
      color: Colors.white,
      height: 30.h,
      child: Text(
        "Anlaşmalı Psikologlarımız",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.h,
            color: Colors.black.withOpacity(0.75)),
      ),
    );
  }

  @override
  double get maxExtent => 30.h;

  @override
  double get minExtent => 30.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _HorizontalFiltersState extends StatefulWidget {
  const _HorizontalFiltersState({
    Key? key,
    required this.types,
    required this.provider,
  }) : super(key: key);

  final List<String> types;
  final All_Psychologists_Provider provider;

  @override
  State<_HorizontalFiltersState> createState() =>
      __HorizontalFiltersStateState();
}

var _filters = ["Hepsi"];

bool isContains(String element) {
  return _filters.contains(element);
}

class __HorizontalFiltersStateState extends State<_HorizontalFiltersState> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 36).r,
                scrollDirection: Axis.horizontal,
                itemCount: widget.types.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_filters.contains(widget.types[index]) ==
                                false) {
                              if (_filters.contains("Hepsi")) {
                                _filters.remove("Hepsi");
                                _filters.add(widget.types[index]);
                              } else if (widget.types[index] == "Hepsi") {
                                _filters = ["Hepsi"];
                              } else {
                                _filters.add(widget.types[index]);
                              }
                            } else {
                              _filters.removeWhere(
                                (element) {
                                  return element == widget.types[index];
                                },
                              );
                              if (_filters.isEmpty) {
                                _filters = ["Hepsi"];
                              }
                            }
                            widget.provider.filtered_psycs(_filters);
                          });
                        },
                        child: Container(
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: isContains(widget.types[index])
                                ? Color(0xff6B337F)
                                : Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 16)
                                .r,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.types[index],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isContains(widget.types[index])
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.2)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final All_Psychologists_Provider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 113.h,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 36).r,
          scrollDirection: Axis.horizontal,
          itemCount: provider.psyc_list!.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 266.w,
                      height: 113.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff6B337F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13, top: 20).r,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xff6B337F),
                                  child:
                                      Image.asset("assets/snackbar/people.png"),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      provider.psyc_list![index].name
                                              .toString() +
                                          " " +
                                          provider.psyc_list![index].surName
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 15.w,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      provider.psyc_list![index].tag![0],
                                      style: TextStyle(
                                        fontSize: 12.w,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 115.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 2, left: 14)
                                            .r,
                                    child: Text(
                                      "50+ başarılı görüşme",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.w,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Container(
                                  width: 73.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 2, left: 14)
                                            .r,
                                    child: Text(
                                      "500₺/Saat",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.w,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: -11,
                        right: -15,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffD9D9D9).withOpacity(0.1),
                          ),
                          width: 76.w,
                          height: 76.w,
                        )),
                  ],
                ),
                SizedBox(width: 15.w)
              ],
            );
          }),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36).r,
      child: SizedBox(
        width: 356.w,
        height: 180.h,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 356.w,
              height: 161.h,
              decoration: BoxDecoration(
                color: const Color(0xff6B337F),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(child: Image.asset("assets/snackbar/bigelipse.png")),
            Positioned(
              bottom: -3,
              child: Image.asset(
                "assets/snackbar/as.png",
                width: 168.w,
                height: 183.h,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/snackbar/Ellipse 763.png"),
            ),
          ],
        ),
      ),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36).r,
      child: SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/login/headlogo.png",
                  width: 50.w,
                  height: 50.w,
                ),
                const Text("LOGOS")
              ],
            ),
            GestureDetector(
                onTap: (() {
                  CustomBottomSheet(context);
                }),
                child: Container(
                  width: 37.w,
                  height: 37.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/home/profile_picture.png"),
                    ),
                    shape: BoxShape.circle,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<dynamic> CustomBottomSheet(BuildContext context) {
    final client =
        Provider.of<ClientProvider>(context, listen: false).get_client.client;
    final cl = Provider.of<ClientProvider>(context, listen: false);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              width: double.infinity,
              height: 700.h,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 20,
                  top: 55,
                ).r,
                child: Column(
                  children: [
                    Text(
                      "Profil Düzenle",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                    Text(
                      "Sadece güncellemek istediğiniz ögeye tıklayınız",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 162.w,
                              height: 110.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/home/profile_picture.png"),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Fotoğrafı Güncelle",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "İsim",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 133.w,
                                height: 30.h,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ).r,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    initialValue: client!.name.toString(),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.25)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Soyisim",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 133.w,
                                height: 30.h,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ).r,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    initialValue: client.surName.toString(),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.25)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21.h),
                    //

                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 40).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "E-posta",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 320.w,
                            height: 30.h,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16).r,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: client.eMail.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.25)),
                              ),
                            ),
                          ),
                          SizedBox(height: 28.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Parola Sıfırlama",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: Colors.black.withOpacity(0.75),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Yeni Parola",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 320.w,
                            height: 30.h,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16).r,
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "●●●●●●●●●●●●●●●",
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.25)),
                                ),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.25)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Yeni Parola Tekrar Giriniz",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 320.w,
                            height: 30.h,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16).r,
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "●●●●●●●●●●●●●●●",
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.25)),
                                ),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.25)),
                              ),
                            ),
                          ),
                          SizedBox(height: 46.h),
                          Row(
                            children: [
                              Container(
                                width: 54.w,
                                height: 54.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF7F7F7),
                                ),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(width: 23.h),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (() {
                                    cl.updateClient();
                                    Navigator.pop(context);
                                  }),
                                  child: Container(
                                    height: 54.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff6B337F),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Güncelle",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
          onTap: (() {
            print("object");
          }),
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
