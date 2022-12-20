// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/models/client_model.dart';
import 'package:logos/screens/login/loginScreenView.dart';

class dddd extends StatefulWidget {
  static const routeName = "/tes";
  const dddd({super.key});

  @override
  State<dddd> createState() => _ddddState();
}

class _ddddState extends State<dddd> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool iserr = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as ClientModel?;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(args!.client!.sId.toString()),
              Text(args.client!.name.toString()),
              Text(args.client!.surName.toString()),
              Text(args.client!.job.toString()),
              Text(args.client!.county.toString()),
              Text(args.client!.dateOfBirth.toString()),
              Text(args.client!.createAt.toString()),
              Text(args.client!.sex.toString()),
            ]),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
    required this.bottomtext,
    required this.width,
    required this.bottomlinktext,
  }) : super(key: key);

  final String bottomtext;
  final double width;
  final String bottomlinktext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          bottomtext,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black.withOpacity(0.6),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: width * 0.023),
        InkWell(
          onTap: () {
            Navigator.of(context).pop(LoginScreenView.routeName);
          },
          child: Text(
            bottomlinktext,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
