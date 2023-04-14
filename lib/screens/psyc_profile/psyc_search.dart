import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:logos/screens/psyc_profile/psycs_profileScreenView.dart';
import 'package:provider/provider.dart';

import '../../models/all_psyc_model.dart';
import '../../providers/all_psyc_provider.dart';
import '../home/favorites_page.dart';

class PsycSearchScreen extends StatelessWidget {
  static const routeName = "/psyc_search";
  const PsycSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final psyc = Provider.of<All_Psychologists_Provider>(context).psyc_list!;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 75).r,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 27).r,
                  child: const CustomAppbar(appBarTitle: "Psikologlar"),
                ),
                SizedBox(
                  height: constraints.maxHeight,
                  child: ListView.builder(
                    itemCount: psyc.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38).r,
                        child: SizedBox(
                          width: 428.w,
                          height: 100.h,
                          child: PsycRow(psyc: psyc[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PsycRow extends StatelessWidget {
  const PsycRow({
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/home/dummypp.png"),
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
          ],
        ),
      ),
    );
  }
}
