import 'package:clone_radish_app/home_screen.dart';
import 'package:clone_radish_app/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            child: _splashedLoadingWidget(snapshot),
          );
        });
  }
}

StatelessWidget _splashedLoadingWidget(AsyncSnapshot snapshot) {
  if (snapshot.hasError) {
    print('에러가 발생하였습니다');
    return const Text('error');
  } else if (snapshot.hasData) {
    return const HomeScreen();
  } else {
    return const SplashScreen();
  }
}
