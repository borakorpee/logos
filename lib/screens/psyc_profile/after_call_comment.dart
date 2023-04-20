import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:logos/screens/psyc_profile/psycs_profileScreenView.dart';
import 'package:provider/provider.dart';
import '../../models/all_psyc_model.dart';
import '../profile/profile_page.dart';

class AfterCallComment extends StatelessWidget {
  static const routeName = "/after-call-comment";
  const AfterCallComment({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, Psychologists?>;
    final client = Provider.of<ClientProvider>(context).get_client.client!;
    final fav = Provider.of<ClientProvider>(context);
    Psychologists? psyc = args["provider"];
    final clientt = Provider.of<ClientProvider>(context).get_client;
    double psycRating = 3;
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(top: 75).r,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30).r,
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
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1)),
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
                          client.favorites!.contains(psyc!.sId)
                              ? fav.removeFavorites(psyc.sId.toString())
                              : fav.addFavorites(psyc.sId.toString());
                        },
                        icon: Image.asset(
                          client.favorites!.contains(psyc!.sId)
                              ? "assets/psyc_profile/bookmark_filled.png"
                              : "assets/psyc_profile/bookmark.png",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                PsycPic(provider: psyc),
                SizedBox(height: 14.h),
                PsycBio(provider: psyc),
                SizedBox(height: 14.h),
                RatingBar.builder(
                  unratedColor: Colors.black.withOpacity(0.15),
                  itemSize: 30.w,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => SvgPicture.asset(
                    "assets/videocall/star.svg",
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    psycRating = rating;
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40, right: 40, top: 30).r,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Yorum Ekle",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                          Text(
                            "Maks. 300 harf",
                            style: TextStyle(
                                color: const Color(0xffA950C9),
                                fontSize: 11.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: 350.w,
                        height: 315.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.35),
                            width: 0.4,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10).r,
                          child: TextField(
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            controller: controller,
                            maxLength: 300,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(25),
                              border: InputBorder.none,
                              hintText:
                                  'Psikolog hakkında düşüncelerinizi yazın.',
                              hintStyle: TextStyle(fontSize: 13.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    print(psycRating);
                    var commentResponse = await http.post(
                      Uri.parse("$root/comment/add"),
                      headers: {
                        "x-access-token": clientt.token.toString(),
                      },
                      body: {
                        "psyc": psyc.sId,
                        "client": clientt.client!.sId,
                        "comments": controller.text,
                      },
                    );
                    var ratingResponse = await http.post(
                      Uri.parse("$root/psyc/createStar"),
                      headers: {
                        "x-access-token": clientt.token.toString(),
                      },
                      body: {
                        "psyc": psyc.sId,
                        "star": psycRating.toString(),
                      },
                    );
                    Navigator.of(context).pop();
                    print(commentResponse.body);
                    print(ratingResponse.body);
                  },
                  child: Container(
                    width: 350.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffA950C9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Değerlendirme Ekle",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
