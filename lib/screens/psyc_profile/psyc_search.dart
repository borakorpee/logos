import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';

class PsycSearchScreen extends StatelessWidget {
  static const routeName = "/psyc_search";
  const PsycSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75).r,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 27, right: 27).r,
            child: const CustomAppbar(appBarTitle: "Doktor Ara"),
          )
        ]),
      ),
    );
  }
}
