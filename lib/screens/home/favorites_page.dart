import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/models/all_psyc_model.dart';
import 'package:provider/provider.dart';

import '../../providers/all_psyc_provider.dart';
import '../../providers/client_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client.client!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 75).r,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Kaydedilenler",
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
              client.favorites!.length == 0
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "Herhangi bir psikolog kayıt etmediniz. Kendinize uygun bir psikolog seçip kaydederek psikoloğunuza dilediğiniz zaman kolay bir şekilde ulaşabilirsiniz.",
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 300.h,
                      child: ListView.builder(
                        itemCount: client.favorites!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final psyc =
                              Provider.of<All_Psychologists_Provider>(context)
                                  .findById(client.favorites![index]);
                          return Card(
                            elevation: 1,
                            child: Column(children: [
                              Text(psyc.name!),
                              Text(psyc.surName!)
                            ]),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
