import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/models/client_model.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/profile/edit_profile_page.dart';
import 'package:provider/provider.dart';

import '../home/new_home.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client!;
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppbar(),
            SizedBox(height: 43.h),
            Bio(client: client),
            SizedBox(height: 25.h),
            Container(
              width: 374.w,
              height: 149.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: const [
                  DetailTo(
                    navigateTo: 'Randevularım',
                    iconPath: 'assets/client_profile/randevularım.svg',
                  ),
                  DetailTo(
                    navigateTo: 'Geçmiş',
                    iconPath: 'assets/client_profile/gecmis.svg',
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

class DetailTo extends StatelessWidget {
  final String navigateTo;
  final String iconPath;

  const DetailTo({
    Key? key,
    required this.navigateTo,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36, top: 22).r,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 10.w),
          Text(
            navigateTo,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //Navigator.of(context).pop();
            },
            child: Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: const Color(0xffF7F7F7),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bio extends StatelessWidget {
  const Bio({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 374.w,
          height: 192.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 50,
              ),
            ],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28, top: 28).r,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoBox(
                          bioTitle: 'İsim',
                          bioData: client.name!,
                        ),
                        SizedBox(height: 25.h),
                        InfoBox(
                          bioTitle: 'İl',
                          bioData: client.city!,
                        ),
                        SizedBox(height: 25.h),
                        InfoBox(
                          bioTitle: 'E-mail',
                          bioData: client.eMail!,
                        ),
                      ],
                    ),
                    SizedBox(width: 30.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoBox(
                          bioTitle: 'Soyisim',
                          bioData: client.surName!,
                        ),
                        SizedBox(height: 25.h),
                        InfoBox(
                          bioTitle: 'İlçe',
                          bioData: client.county!,
                        ),
                        SizedBox(height: 25.h),
                        InfoBox(
                          bioTitle: 'Meslek',
                          bioData: client.job!,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 90.w,
            height: 90.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(130),
                bottomRight: Radius.circular(45),
              ),
              color: Color(0xff6B337F),
            ),
          ),
        ),
        Positioned(
          right: 25.w,
          top: 25.h,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
            },
            child: SizedBox(
              width: 25.w,
              height: 25.h,
              child: SvgPicture.asset("assets/client_profile/edit.svg"),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final String bioTitle;
  final String bioData;
  const InfoBox({
    Key? key,
    required this.bioTitle,
    required this.bioData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bioTitle,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black.withOpacity(0.5),
              fontSize: 10.sp),
        ),
        Text(
          bioData.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.5),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7).r,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
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
          const DrawerButton(),
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        width: 42.w,
        height: 42.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          shape: BoxShape.circle,
        ),
        child: Image.asset("assets/drawer/t.png"),
      ),
    );
  }
}
