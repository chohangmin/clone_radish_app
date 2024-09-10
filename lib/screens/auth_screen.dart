import 'package:clone_radish_app/screens/start/address_page.dart';
import 'package:clone_radish_app/screens/start/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            IntroPage(
              controller: _pageController,
            ),
            const AddressPage(),
            Container(
              color: Colors.accents[5],
            )
          ]),
    );
  }
}
