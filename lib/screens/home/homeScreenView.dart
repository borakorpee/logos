import 'package:flutter/material.dart';
import 'package:logos/screens/profile/profileScreenView.dart';

class HomeScreenView extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreenView.routeName);
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Center(
        child: Text("as"),
      ),
    );
  }
}
