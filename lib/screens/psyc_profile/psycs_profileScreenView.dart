// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/screens/psyc_profile/connecting.dart';
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
        PsycPic(provider: provider),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36).r,
            child: Row(
              children: [
                Container(
                  width: 273.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffA950C9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Randevu Ayarla",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 70.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    "assets/psyc_profile/message.svg",
                    width: 10.w,
                    height: 10.h,
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class AboutSection extends StatefulWidget {
  const AboutSection({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  int tabindex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36).r,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10).r),
        child: Column(
          children: [
            TabBar(
              labelColor: const Color(0xffA950C9),
              unselectedLabelColor: Colors.black.withOpacity(0.25),
              unselectedLabelStyle: TextStyle(fontSize: 13.sp),
              automaticIndicatorColorAdjustment: false,
              indicator: BoxDecoration(
                color: const Color(0xff6B337F).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              controller: widget._tabController,
              tabs: <Widget>[
                Tab(
                  text: "Muayene Detayı",
                  height: 50.h,
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
                controller: widget._tabController,
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
          Spec(
            iconPath: 'assets/psyc_profile/hasta.svg',
            specTitle: 'Hasta',
            stats: '2.56K',
          ),
          Spacer(),
          Spec(
            iconPath: 'assets/psyc_profile/inceleme.svg',
            specTitle: 'İnceleme',
            stats: '5.85K',
          ),
          Spacer(),
          Spec(
            iconPath: 'assets/psyc_profile/tecrube.svg',
            specTitle: 'Tecrübe',
            stats: '8 Sene',
          ),
        ],
      ),
    );
  }
}

class Spec extends StatelessWidget {
  final String specTitle;
  final String iconPath;
  final String stats;

  const Spec({
    Key? key,
    required this.specTitle,
    required this.iconPath,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
          ),
          SizedBox(width: 5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                specTitle,
                style: (TextStyle(
                  color: Colors.black.withOpacity(0.35),
                  fontSize: 10.sp,
                )),
              ),
              Text(
                stats,
                style: TextStyle(
                    color: const Color(0xffA950C9),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
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
          "${provider.unvan} ${provider.name} ${provider.surName}",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: Colors.black.withOpacity(0.75)),
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
                  color: Colors.black.withOpacity(0.35),
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
  final Psychologists provider;

  const PsycPic({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).pushNamed(ConnectingToPsyc.routeName, arguments: {
          "provider": provider,
        });
      },
      child: Container(
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
      padding: const EdgeInsets.only(top: 75, left: 33, right: 33).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
          Text(
            "Randevu Detayları",
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
            ),
          ),
        ],
      ),
    );
  }
}
