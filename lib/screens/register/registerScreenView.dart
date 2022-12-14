// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import '../../components/customBackButton.dart';

class RegisterScreenView extends StatefulWidget {
  static const routeName = "/register";

  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isIdentity_error = false;
  bool isUsername_error = false;
  bool isSex_error = false;
  bool isJob_error = false;
  bool isCity_error = false;
  bool isCounty_error = false;

  final String titletext = "Kayıt ol.";
  final String identity_text = "T.C. Kimlik No";
  final String username_text = "Kullanıcı Adı";
  final String job_text = "Meslek";
  final String City_text = "İl";
  final String County_text = "İlçe";

  String? selectedSex;

  TextEditingController identity_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();
  TextEditingController job_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();
  TextEditingController county_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _key,
        child: Center(
            child: Column(
          children: <Widget>[
            CustomBackButton(context),
            Padding(
              padding:
                  EdgeInsets.only(left: width * 0.110, right: width * 0.110),
              child: Column(
                children: [
                  SizedBox(height: height * 0.044),
                  Logo(width: width, height: height),
                  SizedBox(height: height * 0.06),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: identity_controller,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: identity_text,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isIdentity_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isIdentity_error
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
                                isIdentity_error = true;
                              });
                              return 'Boş bırakılamaz.';
                            } else if (value.length != 11) {
                              setState(() {
                                isIdentity_error = true;
                              });
                              return "Geçeriz";
                            }
                            setState(() {
                              isIdentity_error = false;
                            });
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: width * 0.023),
                      Expanded(
                        child: TextFormField(
                          controller: username_controller,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: username_text,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isUsername_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isUsername_error
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
                                isUsername_error = true;
                              });
                              return 'Boş bırakılamaz.';
                            }
                            setState(() {
                              isUsername_error = false;
                            });
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.017),
                  DropdownButtonFormField<String>(
                      validator: ((value) {
                        if (value == null) {
                          setState(() {
                            isSex_error = true;
                          });
                          return "Boş bırakılamaz";
                        }
                        setState(() {
                          isSex_error = false;
                        });
                      }),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Cinsiyet",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: isSex_error ? Colors.red : Color(0xffDADADA),
                          ),
                        ),
                        fillColor: isSex_error
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
                      value: selectedSex,
                      // ignore: prefer_const_literals_to_create_immutables
                      items: _dropdownitems.map((String user) {
                        return DropdownMenuItem<String>(
                          value: user,
                          child: Text(
                            user,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedSex = v;
                        });
                      }),
                  SizedBox(height: height * 0.017),
                  TextFormField(
                    controller: job_controller,
                    cursorColor: Color(0xff46005F),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: job_text,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: isJob_error ? Colors.red : Color(0xffDADADA),
                        ),
                      ),
                      fillColor: isJob_error
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
                          isJob_error = true;
                        });
                        return 'Boş bırakılamaz.';
                      }
                      setState(() {
                        isJob_error = false;
                      });
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.017),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: city_controller,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: City_text,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isCity_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isCity_error
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
                                isCity_error = true;
                              });
                              return 'Boş bırakılamaz.';
                            }
                            setState(() {
                              isCity_error = false;
                            });
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: width * 0.023),
                      Expanded(
                        child: TextFormField(
                          controller: county_controller,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: County_text,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isCounty_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isCounty_error
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
                                isCounty_error = true;
                              });
                              return 'Boş bırakılamaz.';
                            }
                            setState(() {
                              isCounty_error = false;
                            });
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 54),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xff6B337F),
                      onPressed: () {
                        print(identity_controller.text);
                        print(username_controller.text);
                        print(selectedSex);
                        print(job_controller.text);
                        print(city_controller.text);
                        print(county_controller.text);
                      },
                      child: Icon(
                        Icons.chevron_right,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

var _dropdownitems = [
  "Erkek",
  "Kadın",
  "Belirtmek İstemiyorum",
];

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.17,
      height: height * 0.103,
      child: Image.asset("assets/login/headlogo.png"),
    );
  }
}
