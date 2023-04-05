import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';

class EditProfile extends StatelessWidget {
  static const routeName = "/edit_profile";
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
        child: Column(children: const [CustomAppbar()]),
      ),
    );
  }
}
