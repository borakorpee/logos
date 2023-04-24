// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names, use_build_context_synchronously, use_full_hex_values_for_flutter_colors, must_be_immutable
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/register/kvkkScreenView.dart';
import 'package:logos/screens/register/registerSuccessScreenView.dart';
import 'package:logos/service/auth_service.dart';
import '../../components/customBackButton.dart';

class RegisterScreen2 extends StatefulWidget {
  static const routeName = "/register2";
  const RegisterScreen2({super.key});
  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final String registertext = "Kayıt ol";

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
  bool isKVKK_error = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
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
                                color: isMail_error
                                    ? Colors.red
                                    : Color(0xffDADADA),
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
                              setState(() {
                                isMail_error = true;
                              });
                              return "Lüften geçerli bir mail adresi giriniz. ";
                            }
                            setState(() {
                              isMail_error = false;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.021),
                        PasswordTextField(
                          password_controler: password1,
                          passwordVisible: passwordVisible1,
                          passtext: passtext1,
                          other_controller: password2,
                        ),
                        SizedBox(height: height * 0.016),
                        PasswordTextField(
                          password_controler: password2,
                          passwordVisible: passwordVisible2,
                          passtext: passtext2,
                          other_controller: password1,
                        ),
                        SizedBox(height: height * 0.030),
                        Row(
                          children: [
                            Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 1.0,
                                    color: isKVKK_error
                                        ? Colors.red
                                        : Colors.black),
                              ),
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
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff6A707C),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'kanunu hakkındaki bildiriyi okudum ve kabul ediyorum.',
                                      style: TextStyle(
                                        color: const Color(0xff6A707C99)
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.027),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xff46005F).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                if (kvkk == false) {
                                  setState(() {
                                    isKVKK_error = true;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Lütfen KVKK metnini okuyup kabul ediniz."),
                                  ));
                                } else {
                                  setState(() {
                                    isKVKK_error = false;
                                  });

                                  AuthService.isEmailExists(mail.text)
                                      .then((mail_exist) {
                                    if (mail_exist["status"]) {
                                      setState(() {
                                        isMail_error = true;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Girdiğiniz mail adresi zaten kullanılmakta."),
                                      ));
                                    } else if (mail_exist["status"] == false) {
                                      AuthService.registerClient(
                                              args, password1.text, mail.text)
                                          .then((data) {
                                        Navigator.of(context).pushNamed(
                                            RegisterSuccess.routeName);
                                      });
                                    }
                                  });
                                }
                              }
                            },
                            child: Text(
                              registertext,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    required this.password_controler,
    required this.passwordVisible,
    required this.passtext,
    required this.other_controller,
  }) : super(key: key);

  final TextEditingController password_controler;
  final TextEditingController other_controller;

  bool passwordVisible;
  final String passtext;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPass_error = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.password_controler,
      cursorColor: const Color(0xff46005F),
      obscureText: !widget.passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: widget.passwordVisible
              ? Image.asset("assets/login/passicon.png")
              : Image.asset("assets/login/Vector.png"),
          onPressed: () {
            setState(() {
              widget.passwordVisible = !widget.passwordVisible;
            });
          },
        ),
        contentPadding: const EdgeInsets.only(left: 20, top: 20),
        hintText: widget.passtext,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isPass_error ? Colors.red : const Color(0xffDADADA),
          ),
        ),
        fillColor: isPass_error
            ? const Color(0xffFF0000).withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isPass_error ? Colors.red : const Color(0xffDADADA),
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
        } else if (value != widget.other_controller.text) {
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
