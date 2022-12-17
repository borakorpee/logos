// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logos/screens/register/registerScreen2View.dart';
import '../../components/customBackButton.dart';
import '../login/loginScreenView.dart';

class RegisterScreen3 extends StatefulWidget {
  static const routeName = "/register3";

  const RegisterScreen3({super.key});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isJob_error = false;
  bool isDate_error = false;

  final String job_text = "Meslek";
  final String date_text = "Doğum tarihi";

  TextEditingController job_controller = TextEditingController();

  bool isCity_error = false;
  bool isCounty_error = false;
  final String City_text = "İl";
  final String County_text = "İlçe";
  TextEditingController city_controller = TextEditingController();
  TextEditingController county_controller = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  String apiDate = "";

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (birthDate.month > currentDate.month) {
      age--;
    } else if (currentDate.month == birthDate.month) {
      if (birthDate.day > currentDate.day) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(
              bottom: height * 0.033,
              child: Row(
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
              ),
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  CustomBackButton(context),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.110, right: width * 0.110),
                    child: Column(
                      children: [
                        Logo(width: width, height: height),
                        Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        TextFormField(
                          controller: job_controller,
                          cursorColor: const Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 20),
                            hintText: job_text,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isJob_error
                                    ? Colors.red
                                    : const Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isJob_error
                                ? const Color(0xffFF0000).withOpacity(0.05)
                                : Colors.black.withOpacity(0.05),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
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
                                cursorColor: const Color(0xff46005F),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  hintText: City_text,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: isCity_error
                                          ? Colors.red
                                          : const Color(0xffDADADA),
                                    ),
                                  ),
                                  fillColor: isCity_error
                                      ? const Color(0xffFF0000)
                                          .withOpacity(0.05)
                                      : Colors.black.withOpacity(0.05),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
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
                                cursorColor: const Color(0xff46005F),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  hintText: County_text,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: isCounty_error
                                          ? Colors.red
                                          : const Color(0xffDADADA),
                                    ),
                                  ),
                                  fillColor: isCounty_error
                                      ? const Color(0xffFF0000)
                                          .withOpacity(0.05)
                                      : Colors.black.withOpacity(0.05),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
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
                        SizedBox(height: height * 0.016),
                        GestureDetector(
                          child: TextFormField(
                            controller:
                                dateinput, //editing controller of this TextField
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 20, top: 20),
                              hintText: date_text,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: isDate_error
                                      ? Colors.red
                                      : const Color(0xffDADADA),
                                ),
                              ),
                              fillColor: isDate_error
                                  ? const Color(0xffFF0000).withOpacity(0.05)
                                  : Colors.black.withOpacity(0.05),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xffDADADA),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  isDate_error = true;
                                });
                                return 'Lütfen Doğum tarihinizi giriniz';
                              }
                              setState(() {
                                isDate_error = false;
                              });
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      1900), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                apiDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);

                                //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() => dateinput.text = formattedDate);
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
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
                          backgroundColor: const Color(0xff6B337F),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              Navigator.of(context).pushNamed(
                                  RegisterScreen2.routeName,
                                  arguments: {
                                    'name': args["name"],
                                    'surname': args["surname"],
                                    'sex': args["sex"],
                                    'birth': apiDate,
                                    'job': job_controller.text,
                                    'city': city_controller.text,
                                    'county': county_controller.text,
                                  });
                            }
                          },
                          child: const Icon(
                            Icons.chevron_right,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

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
