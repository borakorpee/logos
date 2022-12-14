import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/register/kvkkScreenView.dart';

import '../../components/customBackButton.dart';

class RegisterScreen2 extends StatefulWidget {
  static const routeName = "/register2";
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

/*  Text(args["identity"]),
                  Text(args["username"]),
                  Text(args["sex"]),
                  Text(args["job"]),
                  Text(args["city"]),
                  Text(args["county"]),*/

class _RegisterScreen2State extends State<RegisterScreen2> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool? kvkk = false;
  bool isMail_error = false;
  final String mailtext = "Mail adresi";
  TextEditingController mail = TextEditingController();

  final String passtext1 = "Şifre";
  bool passwordVisible1 = false;
  TextEditingController password1 = TextEditingController();

  final String passtext2 = "Şifre tekrarı";
  bool passwordVisible2 = false;
  TextEditingController password2 = TextEditingController();
  bool isPass_error = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (() {
          _key.currentState!.validate();
        })),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
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
                      Navigator.of(context).pop();
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
            Column(
              children: <Widget>[
                CustomBackButton(context),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.110, right: width * 0.110),
                  child: Form(
                    key: _key,
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
                        SizedBox(height: height * 0.021),
                        TextFormField(
                          controller: mail,
                          cursorColor: Color(0xff46005F),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
                            hintText: mailtext,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isMail_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isMail_error
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
                                isMail_error = true;
                              });
                              return 'Bu alan boş bırakılamaz.';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Lüften geçerli bir mail adresi giriniz. ";
                            }
                            setState(() {
                              isMail_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.021),
                        TextFormField(
                          controller: password1,
                          cursorColor: Color(0xff46005F),
                          obscureText: !passwordVisible1,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: passwordVisible1
                                  ? Image.asset("assets/login/passicon.png")
                                  : Image.asset("assets/login/Vector.png"),
                              onPressed: () {
                                setState(() {
                                  passwordVisible1 = !passwordVisible1;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
                            hintText: passtext1,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isPass_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isPass_error
                                ? Color(0xffFF0000).withOpacity(0.05)
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
                                isPass_error = true;
                              });
                              return 'Bu alan boş bırakılamaz.';
                            } else if (value != password2.text) {
                              setState(() {
                                isPass_error = true;
                              });
                              return "Girdiğiniz şifreler aynı olmalıdır";
                            }
                            setState(() {
                              isPass_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.016),
                        TextFormField(
                          controller: password2,
                          cursorColor: Color(0xff46005F),
                          obscureText: !passwordVisible2,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: passwordVisible2
                                  ? Image.asset("assets/login/passicon.png")
                                  : Image.asset("assets/login/Vector.png"),
                              onPressed: () {
                                setState(() {
                                  passwordVisible2 = !passwordVisible2;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 20, top: 20),
                            hintText: passtext2,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: isPass_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
                              ),
                            ),
                            fillColor: isPass_error
                                ? Color(0xffFF0000).withOpacity(0.05)
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
                                isPass_error = true;
                              });
                              return 'Bu alan boş bırakılamaz.';
                            } else if (value != password1.text) {
                              setState(() {
                                isPass_error = true;
                              });
                              return "Girdiğiniz şifreler aynı olmalıdır";
                            }
                            setState(() {
                              isPass_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.030),
                        Row(
                          children: [
                            Checkbox(
                              activeColor:
                                  const Color(0xff46005F).withOpacity(0.8),
                              value: kvkk,
                              onChanged: ((value) {
                                setState(() {
                                  kvkk = value;
                                });
                              }),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(KvkkScreen.routeName);
                                    },
                                  text: 'KVKK ',
                                  style: const TextStyle(
                                      color: Color(0xff6A707C),
                                      fontWeight: FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'kanunu hakkındaki bildiriyi okudum ve kabul ediyorum.',
                                      style: TextStyle(
                                          color: Color(0xff6A707C99)
                                              .withOpacity(0.6),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
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
