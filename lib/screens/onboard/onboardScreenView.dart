// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/screens/login/loginScreenView.dart';
import 'package:logos/screens/onboard/onboardModel.dart';

class OnboardScreenView extends StatefulWidget {
  const OnboardScreenView({super.key});

  @override
  State<OnboardScreenView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardScreenView> {
  late PageController _pageController;
  double page = 0.0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //print(height);
    //print(width);

    return Scaffold(
      body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff46005F),
                Color(0xff020202),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.085),
            child: Column(children: <Widget>[
              Logo(width: width, height: height),
              SizedBox(
                width: width,
                height: height - height * 0.40,
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        page = value.toDouble();
                      });
                    },
                    itemCount: OnboardData.length,
                    controller: _pageController,
                    itemBuilder: ((context, index) => Content(
                          height: height,
                          width: width,
                          title: OnboardData[index].title,
                          description: OnboardData[index].description,
                          image: OnboardData[index].image,
                          pageController: _pageController,
                          index: index,
                        ))),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.14, right: width * 0.14),
                child: Column(
                  children: <Widget>[
                    DotsIndicator(
                      dotsCount: OnboardData.length,
                      position: page,
                      decorator: DotsDecorator(activeColor: Colors.white),
                    ),
                    SizedBox(height: height * 0.06),
                    Buttons(width: width, height: height),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: width * 0.325,
          height: height * 0.053,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreenView.routeName);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.9, // thickness
                        color: Colors.white.withOpacity(0.6) // color
                        ),
                    borderRadius: BorderRadius.circular(45))),
            child: Text(
              "Giriş Yap",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: width * 0.325,
          height: height * 0.053,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.9, // thickness
                        color: Colors.white.withOpacity(0.6) // color
                        ),
                    borderRadius: BorderRadius.circular(45))),
            child: Text(
              "Kayıt Ol",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
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
    return Container(
      width: width * 0.315,
      height: height * 0.064,
      child: Image.asset(
        "assets/onboard/logo.png",
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.title,
    required this.description,
    required this.pageController,
    required this.index,
  }) : super(key: key);

  final PageController pageController;
  final String image;
  final String title;
  final String description;
  final double height;
  final double width;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.05),
        Container(
          width: width * 0.616,
          height: height * 0.327,
          child: Image.asset(image),
        ),
        SizedBox(height: height * 0.059),
        Text(
          title,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: height * 0.018),
        Container(
          width: width * 0.77,
          height: height * 0.09,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              description,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
