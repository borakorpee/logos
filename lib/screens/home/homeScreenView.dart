// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
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
  final _filters = [];
  var types = [
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
                    return FilterChip(
                      label: Text(types[index]),
                      selected: _filters.contains(types[index]),
                      onSelected: (val) {
                        setState(() {
                          if (val) {
                            _filters.add(types[index]);
                          } else {
                            _filters.removeWhere((element) {
                              return element == types[index];
                            });
                            provider.filtered_psycs(_filters);
                          }
                        });
                        provider.filtered_psycs(_filters);
                      },
                    );
                  })),
          SizedBox(
            width: 300,
            height: 200,
            child: ListView.builder(
              itemCount: _filters.isEmpty
                  ? provider.psyc_list?.length
                  : provider.filtered_list.length,
              itemBuilder: (BuildContext context, int index) {
                return provider.filtered_list.isEmpty
                    ? NewWidget(
                        provider: provider,
                        index: index,
                      )
                    : NewWidget2(
                        provider: provider,
                        index: index,
                      );
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
