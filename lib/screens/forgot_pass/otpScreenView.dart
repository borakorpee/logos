import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logos/components/customBackButton.dart';

class OtpScreenView extends StatefulWidget {
  static const routeName = "/otp";
  const OtpScreenView({super.key});

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView> {
  bool inputcolor1 = false;
  bool inputcolor2 = false;
  bool inputcolor3 = false;
  bool inputcolor4 = false;
  bool inputcolor5 = false;
  bool inputcolor6 = false;

  @override
  Widget build(BuildContext context) {
    const String titletext = "Onaylama kodu";
    const String descriptiontext =
        "Lütfen hesabın ile bağlantılı olan mail adresine gelen kodu giriniz.";

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: <Widget>[
        CustomBackButton(context),
        Padding(
          padding: EdgeInsets.only(left: width * 0.110, right: width * 0.110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * 0.062),
              Text(
                titletext,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              SizedBox(height: height * 0.026),
              const Text(
                descriptiontext,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff8391A1),
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: height * 0.026),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NewWidget(inputcolor: inputcolor1),
                  NewWidget(inputcolor: inputcolor2),
                  NewWidget(inputcolor: inputcolor3),
                  NewWidget(inputcolor: inputcolor4),
                  NewWidget(inputcolor: inputcolor5),
                  NewWidget(inputcolor: inputcolor6),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class NewWidget extends StatefulWidget {
  NewWidget({
    Key? key,
    required this.inputcolor,
  }) : super(key: key);

  bool inputcolor;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: widget.inputcolor ? Color(0xffA800A4) : Color(0xffE8ECF4),
          ),
          color: Colors.black.withOpacity(0.05)),
      child: TextField(
        onChanged: ((value) {
          FocusScope.of(context).nextFocus();
          if (value == "") {
            setState(() {
              widget.inputcolor = false;
            });
          } else if (value != "") {
            setState(() {
              widget.inputcolor = true;
            });
          }
        }),
        decoration: InputDecoration(border: InputBorder.none),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
