import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _filters = [];
  var types = [
    "Hepsi",
    "psikolog",
    "ergen psikoloğu",
    "klinik psikoloğu",
    "cinsel_terapist",
    "çift terapsiti",
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<All_Psychologists_Provider>(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 55).r,
      child: Column(
        children: [
          const Appbar(),
          const SearchBar(),
          SizedBox(height: 27.w),
          const CustomCard(),
          SizedBox(height: 17.w),
          SizedBox(
            height: 36.h,
            child: Row(
              children: [
                /*FilterChip(
                  showCheckmark: false,
                  selectedColor: _filters.isEmpty
                      ? const Color(0xff6B337F)
                      : Colors.black.withOpacity(0.2),
                  backgroundColor: Colors.black.withOpacity(0.1),
                  selected: _filters.isEmpty ? true : false,
                  label: Text(
                    "Hepsi",
                    style: TextStyle(
                      color: _filters.isEmpty
                          ? Colors.white
                          : Colors.black.withOpacity(0.2),
                      fontSize: 12.h,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onSelected: (_) {
                    setState(() {
                      _filters = [];
                    });
                  },
                ),*/
                SizedBox(width: 10.w),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            FilterChip(
                              showCheckmark: false,
                              selectedColor: Color(0xff6B337F),
                              backgroundColor: Colors.black.withOpacity(0.1),
                              label: Text(
                                types[index],
                                style: TextStyle(
                                  color: _filters.contains(types[index])
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.2),
                                  fontSize: 12.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: _filters.contains(types[index]),
                              onSelected: (val) {
                                setState(() {
                                  if (val) {
                                    if (_filters.contains("Hepsi")) {
                                      _filters.remove("Hepsi");
                                      _filters.add(types[index]);
                                    } else if (types[index] == "Hepsi") {
                                      _filters = ["Hepsi"];
                                    } else {
                                      _filters.add(types[index]);
                                    }
                                  } else {
                                    _filters.removeWhere((element) {
                                      return element == types[index];
                                    });
                                    provider.filtered_psycs(_filters);
                                  }
                                });
                                provider.filtered_psycs(_filters);
                              },
                            ),
                            SizedBox(width: 10.w),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: 29.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tercih Edilen Psikologlar",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.h,
                  color: Colors.black.withOpacity(0.75)),
            ),
          ),
          SizedBox(height: 21.h),
          HorizontalList(provider: provider),
          SizedBox(height: 27.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Anlaşmalı Psikologlarımız",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.h,
                  color: Colors.black.withOpacity(0.75)),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 170,
            child: ListView.builder(
              itemCount: _filters.contains("Hepsi")
                  ? provider.psyc_list?.length
                  : provider.filtered_list.length,
              itemBuilder: (BuildContext context, int index) {
                return _filters.contains("Hepsi")
                    ? Column(
                        children: [
                          Text(provider.psyc_list![index].name.toString())
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                              width: 356.w,
                              height: 98.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFFB6C6D4),
                                      spreadRadius: -8,
                                      blurRadius: 21.0,
                                      offset: Offset(10, 10),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      blurRadius: 6,
                                      offset: Offset(-3, -4),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 13, top: 20)
                                          .r,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white.withOpacity(0.25),
                                            child: Image.asset(
                                                "assets/snackbar/grey.png"),
                                          ),
                                          SizedBox(width: 12.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                provider.filtered_list[index]
                                                        .name
                                                        .toString() +
                                                    " " +
                                                    provider
                                                        .filtered_list[index]
                                                        .surName
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 15.w,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                provider.filtered_list[index]
                                                    .tag![0],
                                                style: TextStyle(
                                                  fontSize: 12.w,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 115.w,
                                                    height: 16.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  top: 2,
                                                                  left: 14)
                                                              .r,
                                                      child: Text(
                                                        "50+ başarılı görüşme",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 8.w,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  Container(
                                                    width: 73.w,
                                                    height: 16.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  top: 2,
                                                                  left: 14)
                                                              .r,
                                                      child: Text(
                                                        "500₺/Saat",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 8.w,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      );
              },
            ),
          )
        ],
      ),
    ));
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final All_Psychologists_Provider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 113.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.psyc_list!.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  width: 266.w,
                  height: 113.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff6B337F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, top: 20).r,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xff6B337F),
                              child: Image.asset("assets/snackbar/people.png"),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  provider.psyc_list![index].name.toString() +
                                      " " +
                                      provider.psyc_list![index].surName
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 15.w,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  provider.psyc_list![index].tag![0],
                                  style: TextStyle(
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 115.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 2, left: 14).r,
                                child: Text(
                                  "50+ başarılı görüşme",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8.w,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Container(
                              width: 73.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 2, left: 14).r,
                                child: Text(
                                  "500₺/Saat",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15.w)
              ],
            );
          }),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356.w,
      height: 161.h,
      decoration: BoxDecoration(
        color: const Color(0xff6B337F),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/login/headlogo.png",
                width: 50,
                height: 50,
              ),
              const Text("LOGOS")
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/home/people.svg",
            ),
            iconSize: 40,
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          hintText: "Psikiyatri Doktoru Ara...",
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: IconButton(
            onPressed: null,
            icon: SvgPicture.asset("assets/home/search.svg"),
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
