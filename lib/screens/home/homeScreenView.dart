// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:logos/screens/profile/profileScreenView.dart';
import 'package:logos/screens/psyc_profile/psycs_profileScreenView.dart';
import 'package:provider/provider.dart';

class HomeScreenView extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  var _filters = ["Tümü"];
  var types = [
    "Tümü",
    "psikolog",
    "ergen psikoloğu",
    "klinik psikoloğu",
    "cinsel_terapist",
    "çift terapsiti",
  ];
  bool isContains(String element) {
    return _filters.contains(element);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<All_Psychologists_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreenView.routeName);
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_filters.contains(types[index]) == false) {
                            if (_filters.contains("Tümü")) {
                              _filters.remove("Tümü");
                              _filters.add(types[index]);
                            } else if (types[index] == "Tümü") {
                              _filters = ["Tümü"];
                            } else {
                              _filters.add(types[index]);
                            }
                          } else {
                            _filters.removeWhere(
                              (element) {
                                return element == types[index];
                              },
                            );
                            if (_filters.isEmpty) {
                              _filters = ["Tümü"];
                            }
                          }
                          provider.filtered_psycs(_filters);
                        });
                      },
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: isContains(types[index])
                              ? Color(0xff6B337F)
                              : Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 16)
                              .r,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                types[index],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: isContains(types[index])
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.2)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 9.w),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: ListView.builder(
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return Text(_filters[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewWidget2 extends StatelessWidget {
  const NewWidget2({
    Key? key,
    required this.provider,
    required this.index,
  }) : super(key: key);

  final All_Psychologists_Provider provider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PsycsScreenView.routeName, arguments: {
          "id": provider.filtered_list[index].sId,
        });
      },
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                FittedBox(
                  child: Text(
                    provider.filtered_list[index].name ?? "",
                  ),
                ),
                const SizedBox(width: 5),
                FittedBox(
                  child: Text(
                    provider.filtered_list[index].surName ?? "",
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.filtered_list[index].tag!.length,
                itemBuilder: (BuildContext context, int indx) {
                  return FilterChip(
                      label: Text(
                        provider.filtered_list[index].tag![indx],
                      ),
                      onSelected: ((value) {}));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.provider,
    required this.index,
  }) : super(key: key);

  final All_Psychologists_Provider provider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PsycsScreenView.routeName, arguments: {
          "id": provider.psyc_list![index].sId,
        });
      },
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                FittedBox(
                  child: Text(
                    provider.psyc_list![index].name ?? "",
                  ),
                ),
                const SizedBox(width: 5),
                FittedBox(
                  child: Text(
                    provider.psyc_list![index].surName ?? "",
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.psyc_list![index].tag!.length,
                itemBuilder: (BuildContext context, int indx) {
                  return FilterChip(
                      label: Text(provider.psyc_list![index].tag![indx]),
                      onSelected: ((value) {}));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
