// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class dddd extends StatelessWidget {
  static const routeName = "/tes";
  const dddd({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
          child: Column(
            children: [
              SizedBox(height: 200),
              TextFormField(
                cursorColor: Color(0xff46005F),
                decoration: dec,
              ),
              SizedBox(height: 100),
              TextFormField(
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Colors.red), //<-- SEE HERE
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration? dec = InputDecoration(
  suffixIcon: Image.asset("assets/login/Vector.png"),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(0xffDADADA),
    ),
  ),
  fillColor: Colors.black.withOpacity(0.05),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(0xffDADADA),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);
