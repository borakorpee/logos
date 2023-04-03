// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/screens/psyc_profile/vide_call.dart';
import 'package:logos/screens/reservation/calendar.dart';
import 'package:provider/provider.dart';

import '../../providers/client_provider.dart';

class PsycsScreenView extends StatefulWidget {
  static const routeName = "/psycs-profile";
  const PsycsScreenView({super.key});

  @override
  State<PsycsScreenView> createState() => _PsycsScreenViewState();
}

class _PsycsScreenViewState extends State<PsycsScreenView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final provider =
        Provider.of<All_Psychologists_Provider>(context).findById(args["id"]);
    return Scaffold(
        body: Column(
      children: [
        const PsycAppbar(),
        SizedBox(height: 25.h),
        const PsycPic(),
        SizedBox(height: 14.h),
        PsycBio(provider: provider),
        SizedBox(height: 14.h),
        const BioRow(),
        SizedBox(height: 24.h),
        AboutSection(tabController: _tabController),
        SizedBox(height: 30.h),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ReservationCalendar.routeName, arguments: {
              "id": provider.sId,
            });
          },
          child: Container(
            width: 356.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: const Color(0xff6B337F),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Text(
              "Randevu Ayarla",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp),
            )),
          ),
        ),
      ],
    ));
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36).r,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20).r),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.black.withOpacity(0.25),
              unselectedLabelStyle: TextStyle(fontSize: 13.sp),
              automaticIndicatorColorAdjustment: false,
              indicator: BoxDecoration(
                color: const Color(0xff6B337F),
                borderRadius: BorderRadius.circular(20),
              ),
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  height: 50.h,
                  text: "Muayene Detayı",
                ),
                Tab(
                  height: 50.h,
                  text: "Doktor Hakkında",
                ),
              ],
            ),
            SizedBox(
              width: 325.w,
              height: 325.h,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28).r,
                      child: Text(
                        """Uyum bozuklukları uzmanı, psikolojik danışmanlık ve terapi hizmetleri sunan bir sağlık profesyonelidir. Uyum bozuklukları, bireylerin hayatlarında önemli bir stres kaynağı olabilir ve iş, okul ve sosyal ilişkiler gibi yaşamın birçok alanını etkileyebilir. Bu nedenle, uyum bozuklukları uzmanları, hastalarının günlük yaşamlarında karşılaştıkları zorluklara yardımcı olmak için özel olarak eğitilirler.

Uyum bozuklukları uzmanları, çeşitli terapi teknikleri kullanarak hastalarının uyum sorunlarını ele alır. Bunlar arasında bilişsel davranışçı terapi, kişilerarası terapi, aile terapisi ve psikodinamik terapi gibi terapiler yer alır. Uzmanlar, hastalarının yaşadıkları sorunları ve hissettikleri duyguları anlamak için bireysel danışmanlık, grup terapisi veya aile terapisi gibi farklı terapi yöntemleri kullanabilirler. """,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28).r,
                      child: Text(
                        """Uyum bozuklukları uzmanı, psikolojik danışmanlık ve terapi hizmetleri sunan bir sağlık profesyonelidir. Uyum bozuklukları, bireylerin hayatlarında önemli bir stres kaynağı olabilir ve iş, okul ve sosyal ilişkiler gibi yaşamın birçok alanını etkileyebilir. Bu nedenle, uyum bozuklukları uzmanları, hastalarının günlük yaşamlarında karşılaştıkları zorluklara yardımcı olmak için özel olarak eğitilirler.

Uyum bozuklukları uzmanları, çeşitli terapi teknikleri kullanarak hastalarının uyum sorunlarını ele alır. Bunlar arasında bilişsel davranışçı terapi, kişilerarası terapi, aile terapisi ve psikodinamik terapi gibi terapiler yer alır. Uzmanlar, hastalarının yaşadıkları sorunları ve hissettikleri duyguları anlamak için bireysel danışmanlık, grup terapisi veya aile terapisi gibi farklı terapi yöntemleri kullanabilirler. """,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BioRow extends StatelessWidget {
  const BioRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Spec(title: 'Tam Zamanlı'),
          Spec(title: '50+ başarılı görüşme'),
          Spec(title: '500₺/Saat'),
        ],
      ),
    );
  }
}

class Spec extends StatelessWidget {
  final String title;
  const Spec({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff6B337F),
      ),
      height: 25.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4).r,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}

class PsycBio extends StatelessWidget {
  const PsycBio({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final Psychologists provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${provider.name} ${provider.surName}",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 18.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: provider.tag!.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                ' ${provider.tag![index][0].toUpperCase()}${provider.tag![index].substring(1)} ${index != provider.tag!.length - 1 ? '|' : ''}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PsycPic extends StatelessWidget {
  const PsycPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135.w,
      height: 135.h,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              "https://www.mecgale.com/wp-content/uploads/2017/08/dummy-profile.png"),
        ),
      ),
    );
  }
}

class PsycAppbar extends StatefulWidget {
  const PsycAppbar({
    Key? key,
  }) : super(key: key);

  @override
  State<PsycAppbar> createState() => _PsycAppbarState();
}

class _PsycAppbarState extends State<PsycAppbar> {
  bool img = false;

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client!;
    final fav = Provider.of<ClientProvider>(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.only(top: 55, left: 33, right: 33).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            "Psikiyatri Detayları",
            style: TextStyle(fontSize: 15.sp),
          ),
          IconButton(
            onPressed: () {
              client.favorites!.contains(args["id"])
                  ? fav.removeFavorites(args["id"])
                  : fav.addFavorites(args["id"]);
            },
            icon: Image.asset(
              client.favorites!.contains(args["id"])
                  ? "assets/psyc_profile/bookmark_filled.png"
                  : "assets/psyc_profile/bookmark.png",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
