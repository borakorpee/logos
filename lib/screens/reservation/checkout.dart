import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/reservation/my_reservation.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/all_psyc_provider.dart';
import '../profile/profile_page.dart';
import "package:http/http.dart" as http;

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    DateTime date = DateFormat('dd.MM.yyyy').parse(args["date"]);
    String apidate = DateFormat('yyyy.MM.dd').format(date);

    String formattedDate = DateFormat('dd MMMM', 'tr_TR').format(date);
    final psyc =
        Provider.of<All_Psychologists_Provider>(context).findById(args["psyc"]);
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27, top: 75).r,
        child: Column(
          children: [
            const CustomAppbar(
              appBarTitle: 'Ödeme Detayları',
            ),
            SizedBox(height: 20.h),
            SizedBox(height: 20.h),
            const PaymentDetails(),
            SizedBox(height: 30.h),
            const PaymentSelection(),
            const Spacer(),
            ProceedCheckoutButton(
              psyc: psyc,
              formattedDate: formattedDate,
              args: args,
              apidate: apidate,
            ),
            SizedBox(height: 44.h),
          ],
        ),
      ),
    );
  }
}

class ProceedCheckoutButton extends StatelessWidget {
  const ProceedCheckoutButton({
    Key? key,
    required this.psyc,
    required this.formattedDate,
    required this.args,
    required this.apidate,
  }) : super(key: key);

  final Psychologists psyc;
  final String formattedDate;
  final String apidate;

  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  width: 390.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40.h),
                      SvgPicture.asset("assets/checkout/done.svg"),
                      SizedBox(height: 15.h),
                      Text(
                        "Ödeme başarılı bir şekilde \n gerçekleşti.",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.65),
                          fontSize: 16.sp,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 17.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "${psyc.unvan} ${psyc.name}${psyc.surName}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.65),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "'den ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                                color: Colors.black.withOpacity(0.45),
                              ),
                            ),
                            TextSpan(
                              text: formattedDate,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                              text: " saat \n",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                                color: Colors.black.withOpacity(0.45),
                              ),
                            ),
                            TextSpan(
                              text: "${args["time1"]}-${args["time2"]} ",
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                              text: "arası olacak şekilde randevu aldınız.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                                color: Colors.black.withOpacity(0.45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      GestureDetector(
                        onTap: () async {
                          var response = await http.post(
                            Uri.parse("$root/reservation/add"),
                            headers: {
                              "x-access-token": client.token.toString()
                            },
                            body: {
                              "psyc": psyc.sId,
                              "client": client.client!.sId,
                              "day": apidate,
                              "time": args["time1"],
                            },
                          );
                          Navigator.popUntil(
                              context, ModalRoute.withName('/psycs-profile'));
                          Navigator.of(context)
                              .pushNamed(MyReservationsPage.routeName);
                        },
                        child: Container(
                          width: 225.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffA950C9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Randevularıma Git",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 356.w,
        height: 60.h,
        decoration: BoxDecoration(
            color: const Color(0xffA950C9),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Ödeme Yap",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentSelection extends StatelessWidget {
  const PaymentSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356.w,
      height: 220.h,
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
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nasıl ödeme yapmak istersiniz?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "Ödeme yapmak için istediğiniz ödeme türünü seçin",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 10.h),
            const Divider(thickness: 1),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 75.w,
                  height: 50.h,
                  child: SvgPicture.asset(
                    "assets/checkout/Visa.svg",
                  ),
                ),
                SizedBox(
                  width: 75.w,
                  height: 50.h,
                  child: SvgPicture.asset(
                    "assets/checkout/Maestro.svg",
                  ),
                ),
                SizedBox(
                  width: 75.w,
                  height: 50.h,
                  child: SvgPicture.asset(
                    "assets/checkout/Mastercard.svg",
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

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ödeme Detayları",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Muayene Ücreti",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "199.90₺",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "KDV (%18)",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "49.90₺",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 11.h),
            const Divider(thickness: 1),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Toplam Tutar",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "249.80₺",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
