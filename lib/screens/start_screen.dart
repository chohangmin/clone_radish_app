import 'package:clone_radish_app/screens/start/address_page.dart';
import 'package:clone_radish_app/screens/start/auth_page.dart';
import 'package:clone_radish_app/screens/start/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              IntroPage(),
              AddressPage(),
              AuthPage(),
            ]),
      ),
    );
  }
}
