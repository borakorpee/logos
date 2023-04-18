// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';
import 'package:logos/screens/home/new_home.dart';
import 'package:http/http.dart' as http;
import 'package:logos/screens/reservation/completed_reservations.dart';
import 'package:provider/provider.dart';
import '../profile/profile_page.dart';

class MyReservationsPage extends StatefulWidget {
  static const routeName = "/my_reservations";
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client;
    return Scaffold(
        drawer: const CustomDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.only(top: 75).r,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27).r,
                    child: const CustomAppbar(appBarTitle: "Randevularım"),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36).r,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10).r),
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: const Color(0xffA950C9),
                            unselectedLabelColor:
                                Colors.black.withOpacity(0.25),
                            unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                            automaticIndicatorColorAdjustment: false,
                            indicator: BoxDecoration(
                              color: const Color(0xff6B337F).withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            controller: _tabController,
                            tabs: <Widget>[
                              Tab(
                                text: "Aktif",
                                height: 40.h,
                              ),
                              Tab(
                                height: 40.h,
                                text: "Geçmiş",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: constraints.maxHeight - 185.h,
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                FutureBuilder(
                                  future: getActiveReservations(
                                      client.client!.sId, client.token),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DateTime date = DateTime.parse(
                                                snapshot.data[index].day);
                                            String formattedDate =
                                                DateFormat('dd MMMM y', 'tr')
                                                    .format(date);

                                            return Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Container(
                                                          width: 70.w,
                                                          height: 70.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/home/dummypp.png"),
                                                                fit: BoxFit
                                                                    .contain),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 20.w),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data[index].psycId.unvan} ${snapshot.data[index].psycId.name} ${snapshot.data[index].psycId.surName}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.75),
                                                            ),
                                                          ),
                                                          SizedBox(height: 2.h),
                                                          Text(
                                                            snapshot.data[index]
                                                                .psycId.tag![0],
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.35),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/checkout/Union.svg"),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                formattedDate,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.35),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                "Saat: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.35),
                                                                  fontSize:
                                                                      12.sp,
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .time,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.35),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          String resId =
                                                              snapshot
                                                                  .data[index]
                                                                  .sId;
                                                          var response =
                                                              await http.delete(
                                                                  Uri.parse(
                                                                      "$root/reservation/delete/${resId}"),
                                                                  headers: {
                                                                "x-access-token":
                                                                    client.token
                                                                        .toString()
                                                              });

                                                          print(response.body);
                                                          setState(() {});
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 40.w,
                                                              height: 40.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                        0xffF0735A)
                                                                    .withOpacity(
                                                                        0.10),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/checkout/deleteRes.svg",
                                                                width: 15.w,
                                                                height: 15.h,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Text(
                                                              "İptal Et",
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xffF0735A),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 8.sp,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                ),
                                FutureBuilder(
                                  future: getInactiveReservations(
                                      client.client!.sId, client.token),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return InactiveReservations(
                                        snapshot: snapshot,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Future<List<Reservation>> getActiveReservations(
      String? clientId, String? cltoken) async {
    beforeResModel before_res = beforeResModel(
      status: null,
      message: '',
      reservation: [],
    );
    var response = await http.get(
        Uri.parse("$root/reservation/after?client_id=$clientId&limit=100"),
        headers: {
          "x-access-token": cltoken.toString(),
        });
    before_res = beforeResModel.fromJson(jsonDecode(response.body));
    return before_res.reservation!;
  }

  Future<List<Reservation>> getInactiveReservations(
      String? clientId, String? cltoken) async {
    beforeResModel before_res = beforeResModel(
      status: null,
      message: '',
      reservation: [],
    );
    var response = await http.get(
        Uri.parse("$root/reservation/before?client_id=$clientId&limit=100"),
        headers: {
          "x-access-token": cltoken.toString(),
        });

    before_res = beforeResModel.fromJson(jsonDecode(response.body));
    return before_res.reservation!;
  }
}

class InactiveReservations extends StatelessWidget {
  final dynamic snapshot;
  const InactiveReservations({
    Key? key,
    this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime date = DateTime.parse(snapshot.data[index].day);
          String formattedDate = DateFormat('dd MMMM y', 'tr').format(date);

          return Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 70.w,
                        height: 70.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/home/dummypp.png"),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data[index].psycId.unvan} ${snapshot.data[index].psycId.name} ${snapshot.data[index].psycId.surName}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          snapshot.data[index].psycId.tag![0],
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/checkout/Union.svg"),
                            SizedBox(width: 5.w),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.35),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Saat: ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              snapshot.data[index].time,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.35),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            CompletedReservations.routeName,
                            arguments: {
                              "id": snapshot.data[index].psycId.sId,
                              "date": formattedDate,
                              "time": snapshot.data[index].time,
                            });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: const Color(0xff0093B3).withOpacity(0.10),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/checkout/details.svg",
                              width: 15.w,
                              height: 15.h,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Detay",
                            style: TextStyle(
                              color: const Color(0xff0093B3),
                              fontWeight: FontWeight.w500,
                              fontSize: 8.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          );
        });
  }
}

class beforeResModel {
  bool? status;
  String? message;
  List<Reservation>? reservation;

  beforeResModel({this.status, this.message, this.reservation});

  beforeResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reservation'] != null) {
      reservation = <Reservation>[];
      json['reservation'].forEach((v) {
        reservation!.add(new Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  String? sId;
  String? day;
  String? time;
  PsycId? psycId;

  Reservation({this.sId, this.day, this.time, this.psycId});

  Reservation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    time = json['time'];
    psycId =
        json['psyc_id'] != null ? new PsycId.fromJson(json['psyc_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['day'] = this.day;
    data['time'] = this.time;
    if (this.psycId != null) {
      data['psyc_id'] = this.psycId!.toJson();
    }
    return data;
  }
}

class PsycId {
  String? sId;
  String? unvan;
  String? name;
  String? surName;
  List<String>? tag;

  PsycId({this.sId, this.unvan, this.name, this.surName, this.tag});

  PsycId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    unvan = json['unvan'];
    name = json['name'];
    surName = json['surName'];
    tag = json['tag'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['unvan'] = this.unvan;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['tag'] = this.tag;
    return data;
  }
}
