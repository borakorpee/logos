import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../profile/profile_page.dart';
import '../psyc_profile/psycs_profileScreenView.dart';

class CompletedReservations extends StatelessWidget {
  static const routeName = "/completed-reservetinos";
  const CompletedReservations({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final provider =
        Provider.of<All_Psychologists_Provider>(context).findById(args["id"]);
    return Scaffold(
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 75).r,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 27).r,
              child: const CustomAppbar(appBarTitle: "Randevu Detayları"),
            ),
            SizedBox(height: 25.h),
            PsycPic(
              provider: provider,
            ),
            SizedBox(height: 14.h),
            PsycBio(provider: provider),
            SizedBox(height: 14.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spec(
                    iconPath: 'assets/home/Union.svg',
                    specTitle: 'Tarih',
                    stats: args["date"],
                  ),
                  const Spacer(),
                  Spec(
                    iconPath: 'assets/psyc_profile/inceleme.svg',
                    specTitle: 'Saat',
                    stats: args["time"],
                  ),
                  const Spacer(),
                  const Spec(
                    iconPath: 'assets/psyc_profile/tecrube.svg',
                    specTitle: 'Görüşme Süresi',
                    stats: '8 Sene',
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              width: 350.w,
              height: 450.h,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Psikiyatrist Yorumu",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.75),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        dummyText,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.35),
                            fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const dummyText =
    """Hastamın TSSB semptomlarındaki ilerleme son derece olumlu oldu. İlk değerlendirme sırasında yaşadığı yoğun korku, panik ataklar ve uykusuzluk gibi semptomlarının birçoğu azaldı veya tamamen ortadan kalktı.
   
Terapi sırasında, hastam duygu düzenleme becerileri konusunda önemli bir ilerleme kaydetti ve bu beceriler, günlük hayatında da uygulayabileceği bir şekilde öğretildi. Tedavi sürecinde, hastamın kendine güveni de arttı ve daha önce yapamadığı birçok şeyi yapmak için cesaret kazandı. Hastamın hayat kalitesi ve işlevselliği önemli ölçüde arttı.

Kendisiyle yaptığımız son görüşmede, artık TSSB semptomlarının daha az şiddetli ve daha az sıklıkla ortaya çıktığını bildirdi ve yaşam kalitesinin önemli ölçüde arttığını belirtti. Bu sonuçlar beni son derece mutlu ediyor ve hastamın tedavi sürecindeki başarısı için gurur duyuyorum. 

Terapi sırasında, hastam duygu düzenleme becerileri konusunda önemli bir ilerleme kaydetti ve bu beceriler, günlük hayatında da uygulayabileceği bir şekilde öğretildi. Tedavi sürecinde, hastamın kendine güveni de arttı ve daha önce yapamadığı birçok şeyi yapmak için cesaret kazandı. Hastamın hayat kalitesi ve işlevselliği önemli ölçüde arttı.

  """;
