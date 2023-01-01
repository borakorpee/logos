import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 55),
      child: Column(
        children: [
          Appbar(),
          SearchBar(),
        ],
      ),
    ));
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/login/headlogo.png",
                width: 50,
                height: 50,
              ),
              const Text("LOGOS")
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/home/people.svg",
            ),
            iconSize: 40,
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          hintText: "Psikiyatri Doktoru Ara...",
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: IconButton(
            onPressed: null,
            icon: SvgPicture.asset("assets/home/search.svg"),
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
