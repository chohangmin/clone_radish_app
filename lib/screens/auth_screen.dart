import 'package:clone_radish_app/screens/start/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(children: [
        const IntroPage(),
        Container(
          color: Colors.accents[2],
        ),
        Container(
          color: Colors.accents[5],
        )
      ]),
    );
  }
}
