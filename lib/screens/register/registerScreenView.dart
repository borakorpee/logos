// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/register/registerScreen3View.dart';
import '../../components/customBackButton.dart';

class RegisterScreenView extends StatefulWidget {
  static const routeName = "/register";

  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isName_error = false;
  bool isSurname_error = false;
  bool isIdentity_error = false;
  bool isUsername_error = false;
  bool isSex_error = false;
  bool isJob_error = false;

  final String titletext = "Kayıt ol.";
  final String identity_text = "T.C. Kimlik No";
  final String username_text = "Kullanıcı Adı";
  final String name_text = "İsim";
  final String surname_text = "Soyisim";

  final String job_text = "Meslek";

  String? selectedSex;
  TextEditingController name_controller = TextEditingController();
  TextEditingController surname_controller = TextEditingController();

  TextEditingController identity_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();
  TextEditingController job_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: height * 0.033,
              child: BottomText(width: width),
            ),
            Form(
              key: _key,
              child: Center(
                  child: Column(
                children: <Widget>[
                  CustomBackButton(context),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.110, right: width * 0.110),
                    child: Column(
                      children: [
                        Logo(width: width, height: height),
                        Title(),
                        SizedBox(height: height * 0.03),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: name_controller,
                                cursorColor: Color(0xff46005F),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 20),
                                  hintText: name_text,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: isName_error
                                          ? Colors.red
                                          : Color(0xffDADADA),
                                    ),
                                  ),
                                  fillColor: isName_error
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
                                      isName_error = true;
                                    });
                                    return 'Boş bırakılamaz.';
                                  }
                                  setState(() {
                                    isName_error = false;
                                  });
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: width * 0.023),
                            Expanded(
                              child: TextFormField(
                                controller: surname_controller,
                                cursorColor: Color(0xff46005F),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 20, top: 20),
                                  hintText: surname_text,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: isSurname_error
                                          ? Colors.red
                                          : Color(0xffDADADA),
                                    ),
                                  ),
                                  fillColor: isSurname_error
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
                                      isSurname_error = true;
                                    });
                                    return 'Boş bırakılamaz.';
                                  }
                                  setState(() {
                                    isSurname_error = false;
                                  });
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.017),
                        TextFormField(
                          controller: identity_controller,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
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
                              return "Tc kimlik numarası 11 haneden oluşmalı";
                            }
                            setState(() {
                              isIdentity_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.017),
                        DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null) {
                                setState(() {
                                  isSex_error = true;
                                });
                                return "Boş bırakılamaz";
                              }
                              setState(() {
                                isSex_error = false;
                              });
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 20),
                              hintText: "Cinsiyet",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: isSex_error
                                      ? Colors.red
                                      : Color(0xffDADADA),
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
                        SizedBox(height: height * 0.017),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.016),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.110, right: width * 0.110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          elevation: 0,
                          backgroundColor: Color(0xff6B337F),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              Navigator.of(context).pushNamed(
                                  RegisterScreen3.routeName,
                                  arguments: {
                                    "name": name_controller.text,
                                    "surname": surname_controller.text,
                                    "sex": selectedSex,
                                  });
                            }
                          },
                          child: Icon(
                            Icons.chevron_right,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    ));
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Kayıt Ol",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Hesabın var mı?",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black.withOpacity(0.6),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: width * 0.023),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreenView.routeName,
                (Route<dynamic> route) => route.isFirst);
          },
          child: Text(
            "Giriş yap",
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
