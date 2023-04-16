import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../profile/profile_page.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final provider =
        Provider.of<All_Psychologists_Provider>(context).findById(args["psyc"]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
        child: Column(children: [
          const CustomAppbar(
            appBarTitle: 'Ödeme Detayları',
          ),
          SizedBox(height: 20.h),
          Container(
            width: 356.w,
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
          ),
        ]),
      ),
    );
  }
}
