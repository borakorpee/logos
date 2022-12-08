import 'package:flutter/material.dart';

Widget CustomBackButton(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(top: height * 0.08, left: width * 0.07),
    child: Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ],
    ),
  );
}
