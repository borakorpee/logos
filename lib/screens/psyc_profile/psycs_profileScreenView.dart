// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:logos/providers/all_psyc_provider.dart';
import 'package:provider/provider.dart';

class PsycsScreenView extends StatelessWidget {
  static const routeName = "/psycs-profile";
  const PsycsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final provider =
        Provider.of<All_Psychologists_Provider>(context).findById(args["id"]);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(provider.name.toString()),
            Text(provider.surName.toString()),
            Text(provider.eMail.toString()),
            Text(provider.tag.toString()),
            Text(provider.unvan.toString()),
            Text(provider.about.toString()),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.tag!.length,
                itemBuilder: (BuildContext context, int indx) {
                  return FilterChip(
                      label: Text(
                        provider.tag![indx],
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
