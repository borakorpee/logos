// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logos/screens/forgot_pass/email_OTP.dart';

class KvkkScreen extends StatefulWidget {
  static const routeName = "/kvkk-screen";
  const KvkkScreen({super.key});

  @override
  State<KvkkScreen> createState() => _KvkkScreenState();
}

class _KvkkScreenState extends State<KvkkScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: height * 0.08, left: width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: height * 0.012,
                      child: Text(
                        "GİZLİLİK SÖZLEŞMESİ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.chevron_left),
                            ),
                            SizedBox(width: width * 0.1),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: width * 0.8,
                              height: height * 0.043,
                              child: Text(
                                "KİŞİSEL VERİLERİN KORUNMASI KANUNU(6698 S.K.) KAPSAMI\n VE GENELGİZLİLİK SÖZLEŞMESİ",
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: kvkk.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.01,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title(
                                    titletext:
                                        kvkk.entries.elementAt(index).key,
                                  ),
                                  description(
                                    text: kvkk.entries.elementAt(index).value,
                                    height: height,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class description extends StatelessWidget {
  description({
    Key? key,
    required this.text,
    this.height,
  }) : super(key: key);

  final String text;
  final height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: height * 0.021),
      ],
    );
  }
}

class title extends StatelessWidget {
  const title({
    Key? key,
    required this.titletext,
  }) : super(key: key);
  final String titletext;
  @override
  Widget build(BuildContext context) {
    return Text(
      titletext,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }
}
