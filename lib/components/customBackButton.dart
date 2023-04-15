// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomBackButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 65, left: 34, right: 34).r,
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
