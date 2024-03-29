import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../../providers/client_provider.dart';
import '../forgot_pass/email_OTP.dart';
import '../psyc_profile/psycs_profileScreenView.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = "/favorites";
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client!;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75).r,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 27, right: 27).r,
                child: const CustomAppbar(
                  appBarTitle: 'Favori Psikologlarım',
                ),
              ),
              client.favorites!.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "Herhangi bir psikolog kayıt etmediniz. Kendinize uygun bir psikolog seçip kaydederek psikoloğunuza dilediğiniz zaman kolay bir şekilde ulaşabilirsiniz.",
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 650.h,
                      child: ListView.builder(
                        itemCount: client.favorites!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final psyc =
                              Provider.of<All_Psychologists_Provider>(context)
                                  .findById(client.favorites![index]);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 38).r,
                            child: SizedBox(
                                width: 428.w,
                                height: 100.h,
                                child: FavRow(psyc: psyc)),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavRow extends StatelessWidget {
  const FavRow({
    Key? key,
    required this.psyc,
  }) : super(key: key);

  final Psychologists psyc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PsycsScreenView.routeName, arguments: {"id": psyc.sId});
      },
      child: Container(
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("$imgroot/uploads/${psyc.image}"),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${psyc.unvan} ${psyc.name} ${psyc.surName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Row(
                      children: [
                        const StarIcon(),
                        SizedBox(width: 5.w),
                        const StarIcon(),
                        SizedBox(width: 5.w),
                        const StarIcon(),
                        SizedBox(width: 5.w),
                        const StarIcon(),
                        SizedBox(width: 5.w),
                        const StarIcon(),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "4.6 (1526 Oylama)",
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  psyc.tag![0],
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black.withOpacity(0.35),
                  ),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final deletefav = Provider.of<ClientProvider>(context);

                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: IntrinsicHeight(
                        child: Container(
                          width: 390.w,
                          height: 276.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                        left: 55, right: 55, top: 33)
                                    .r,
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 70.w,
                                        height: 70.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/home/dummypp.png"),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${psyc.unvan} ${psyc.name} ${psyc.surName}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.75),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const StarIcon(),
                                                SizedBox(width: 5.w),
                                                const StarIcon(),
                                                SizedBox(width: 5.w),
                                                const StarIcon(),
                                                SizedBox(width: 5.w),
                                                const StarIcon(),
                                                SizedBox(width: 5.w),
                                                const StarIcon(),
                                              ],
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "4.6 (1526 Oylama)",
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          psyc.tag![0],
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                Colors.black.withOpacity(0.35),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Favorilerden kaldırmak \nistediğinize emin misiniz?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.65),
                                    fontSize: 15.sp),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffA950C9)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "İptal",
                                          style: TextStyle(
                                              color: const Color(0xffA950C9),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deletefav.removeFavorites(psyc.sId!);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffA950C9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Kaldır",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
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
                    );
                  },
                );
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffF0735A).withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: const Color(0xffF0735A),
                        size: 15.w,
                      ),
                    ),
                    Text(
                      "Kaldır",
                      style: TextStyle(
                        color: const Color(0xffF0735A),
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.w,
      height: 9.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home/Star 11.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
