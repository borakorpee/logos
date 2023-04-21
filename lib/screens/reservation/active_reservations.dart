import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/models/client_model.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../psyc_profile/psycs_profileScreenView.dart';

class ActiveReservations extends StatefulWidget {
  static const routeName = "/active-reservations";
  const ActiveReservations({super.key});

  @override
  State<ActiveReservations> createState() => _ActiveReservationsState();
}

class _ActiveReservationsState extends State<ActiveReservations> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Her dakika ekranı yenilemek için Timer oluşturuluyor
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        // Yenileme işlemleri burada yapılabilir
      });
    });
  }

  @override
  void dispose() {
    // Timer'ı iptal etmek için dispose metodunda cancel() metodunu çağırın
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final psyc =
        Provider.of<All_Psychologists_Provider>(context).findById(args["id"]);
    final client = Provider.of<ClientProvider>(context).get_client.client!;
    DateTime years = DateTime.parse(client.dateOfBirth.toString());
    Duration difference = DateTime.now().difference(years);
    int client_years = (difference.inDays / 365).floor();
    final String date = args["date"];
    final String timee = args["time"];
    DateTime time = DateFormat('HH.mm').parse(timee);
    Duration addedDuration = Duration(hours: 1);
    DateTime newTime = time.add(addedDuration);
    String formattedTime = DateFormat('HH.mm').format(newTime);
    DateTime datee = DateTime.parse(date);
    String formattedDate = DateFormat('EEEE, d MMMM y', 'tr_TR').format(datee);

    DateTime simdikiZaman = DateTime.now();

    DateTime tarih = DateTime.parse(date);
    DateFormat format = DateFormat('yyyy-MM-dd');

    DateTime formattedtarih = format.parse(simdikiZaman.toString());
    DateFormat formatsimdi = DateFormat('yyyy-MM-dd');
    String simdii = format.format(formattedtarih);
    String suan = DateFormat("HH:mm").format(simdikiZaman);

    DateTime formattedsimdi = format.parse(simdii);

    String hedef = DateFormat("HH:mm").format(time);
    DateTime dateTime1 = DateTime.parse("1970-01-01 $hedef:00.000");
    DateTime dateTime2 = DateTime.parse("1970-01-01 $suan:00.000");
    Duration saatfarki = dateTime1.difference(dateTime2);
    int hours = saatfarki.inHours;
    int minutes = saatfarki.inMinutes.remainder(60);

    String formattedDuration = "$hours saat $minutes dakika";
    bool isToday = tarih == formattedsimdi ? true : false;
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 75).r,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 27).r,
              child: const CustomAppbar(appBarTitle: "Aktif Randevu"),
            ),
            SizedBox(height: 40.h),
            Header(psyc: psyc),
            SizedBox(height: 30.h),
            BioRow(psyc: psyc),
            SizedBox(height: 40.h),
            ReservationDetails(
                formattedDate: formattedDate,
                timee: timee,
                formattedTime: formattedTime),
            SizedBox(height: 15.h),
            clientBio(client_years: client_years, client: client),
            SizedBox(height: 15.h),
            const BillContainer(),
            const Spacer(),
            Container(
              width: 355.w,
              height: 57.h,
              decoration: BoxDecoration(
                color: const Color(0xffA950C9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  isToday
                      ? hours == 0
                          ? "Görüşmeniz $minutes dakika sonra başlayacak"
                          : "Görüşmeniz $hours $minutes dakika sonra başlayacak"
                      : "Görüşme saatinde başlayacak",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 45.h),
          ],
        ),
      ),
    );
  }
}

class BillContainer extends StatelessWidget {
  const BillContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 145.h,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ödeme Detayları",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Muayene Ücreti",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "199.90₺",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "KDV (%18)",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "49.90₺",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Toplam Tutar",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "249.80₺",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
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

class clientBio extends StatelessWidget {
  const clientBio({
    Key? key,
    required this.client_years,
    required this.client,
  }) : super(key: key);

  final int client_years;
  final Client client;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 145.h,
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
        padding: const EdgeInsets.only(
          top: 22,
          left: 25,
          bottom: 22,
        ).r,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Hasta Detayı",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  "Ad Soyad",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "Yaş",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "E posta",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  ": $client_years",
                  style: const TextStyle(color: Colors.transparent),
                ),
                Text(
                  ": ${client.name} ${client.surName} ",
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  ": $client_years",
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  ": ${client.eMail} ",
                  style: TextStyle(
                    fontSize: 13.sp,
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

class ReservationDetails extends StatelessWidget {
  const ReservationDetails({
    Key? key,
    required this.formattedDate,
    required this.timee,
    required this.formattedTime,
  }) : super(key: key);

  final String formattedDate;
  final String timee;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 120.h,
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
        padding: const EdgeInsets.only(top: 20, left: 25, bottom: 20).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Randevu zamanı",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  "Tarih",
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                SizedBox(width: 53.w),
                Text(
                  ": $formattedDate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Saat",
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                SizedBox(width: 55.w),
                Text(
                  ": $timee - $formattedTime",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
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

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.psyc,
  }) : super(key: key);

  final Psychologists psyc;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90.w,
                height: 90.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.mecgale.com/wp-content/uploads/2017/08/dummy-profile.png"))),
              ),
              SizedBox(width: 15.w),
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
                  SizedBox(height: 2.h),
                  Text(
                    psyc.tag![0],
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 75).r,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff53C797),
                      borderRadius: BorderRadius.circular(5)),
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      child: Text(
                        "Aktif Randevu",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
