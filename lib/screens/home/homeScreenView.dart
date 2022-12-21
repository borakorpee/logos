import 'package:flutter/material.dart';
import 'package:logos/screens/profile/profileScreenView.dart';

class HomeScreenView extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<Map<String, dynamic>> docs = [
    {
      "name": "ali",
      "domains": ["Danışmanlık Psikologları", "Klinik Psikologlar"],
    },
    {
      "name": "alper",
      "domains": ["Bilişsel Nöropsikologlar", "Klinik Psikologlar"],
    },
    {
      "name": "şahin",
      "domains": ["Danışmanlık Psikologları", "Klinik Psikologlar"],
    },
    {
      "name": "bora",
      "domains": ["Eğitim Psikologları", "Askeri Psikologlar"],
    },
  ];
  List<Map<String, dynamic>> yeni_liste = [];

  List<Map<String, dynamic>> doktor(
    List filterlist,
  ) {
    yeni_liste = [];
    for (var filter in filterlist) {
      for (var doc in docs) {
        doc.forEach((key, values) {
          if (key == "domains") {
            for (var value in values) {
              if (value == filter) {
                yeni_liste.add(doc);
              }
            }
          }
        });
      }
    }
    yeni_liste = yeni_liste.toSet().toList();
    return yeni_liste;
  }

  var _filters = [];
  var types = [
    "Klinik Psikologlar",
    "Danışmanlık Psikologları",
    "Bilişsel Nöropsikologlar",
    "Eğitim Psikologları",
    "Endüstriyel-örgütsel psikologlar",
    "Askeri Psikologlar",
    "Kişilik psikologları",
    "Topluluk psikologları"
  ];
  @override
  Widget build(BuildContext context) {
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
                            doktor(_filters);
                          }
                        });
                        doktor(_filters);
                      },
                    );
                  })),
          SizedBox(
            width: 300,
            height: 200,
            child: ListView(
              children: yeni_liste
                  .map(
                    (e) => Card(
                      child: Text(e.values.toString()),
                    ),
                  )
                  .toList(),
            ),
          ),
          IconButton(
            onPressed: () {
              yeni_liste.forEach((element) {
                print(element.toString());
              });
            },
            icon: Icon(Icons.people),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                yeni_liste = [];
              });
            },
            icon: Icon(Icons.reset_tv),
          )
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

class deneme {}
