import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../../providers/client_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75).r,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Kaydedilenler",
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                textAlign: TextAlign.center,
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
                            padding: const EdgeInsets.only(top: 10).r,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30)
                                        .r,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  width: 356.w,
                                  height: 119.h,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                            vertical: 17, horizontal: 20)
                                        .r,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  "https://www.mecgale.com/wp-content/uploads/2017/08/dummy-profile.png"),
                                            ),
                                            SizedBox(width: 20.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${psyc.name!} ${psyc.surName!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.sp),
                                                ),
                                                Text(
                                                  psyc.tag![0],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 119.w,
                                                    height: 18.h,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff6B337F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  left: 14)
                                                              .r,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: 5,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.w,
                                                              ),
                                                              SizedBox(
                                                                  width: 4.w),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Container(
                                                    width: 85.w,
                                                    height: 19.h,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff6B337F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "500₺/Saat",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "İstanbul, Türkiye",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black
                                                            .withOpacity(0.25)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
