// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Form(
        key: _key,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
            child: Column(
              children: [
                SizedBox(height: 200),
                TextFormField(
                  cursorColor: Color(0xff46005F),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Image.asset("assets/login/Vector.png"),
                      onPressed: () {
                        print(iserr.toString());
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color(0xffDADADA),
                      ),
                    ),
                    fillColor: iserr
                        ? Color(0xffFF0000).withOpacity(0.05)
                        : Colors.black.withOpacity(0.05),
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        iserr = true;
                      });

                      return 'Field is required.';
                    }
                    setState(() {
                      iserr = false;
                    });
                    return null;
                  },
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            print("form submitted.");
          }
        },
      ),
    );
  }
}
