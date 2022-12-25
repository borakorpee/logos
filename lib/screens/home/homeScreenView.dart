// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:logos/models/all_psyc_model.dart';
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
  var _filters = [];
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
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PsycsScreenView.routeName, arguments: {
                            "id": provider.psyc_list![index].sId,
                          });
                        },
                        child: Card(
                          child: Column(
                            children: [
                              FittedBox(
                                child: Text(
                                    provider.psyc_list![index].tag.toString()),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Card(
                        child: Column(
                          children: [
                            FittedBox(
                              child: Text(
                                  provider.filtered_list[index].tag.toString()),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setFilters(bool val, int index) {
    setState(() {
      if (val) {
        _filters.add(types[index]);
      } else {
        _filters.removeWhere((element) {
          return element == types[index];
        });
      }
    });
  }
}
