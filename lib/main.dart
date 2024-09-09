import 'package:beamer/beamer.dart';
import 'package:clone_radish_app/router/locations.dart';
import 'package:clone_radish_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final _routerDelegate = BeamerDelegate(
  locationBuilder:
      BeamerLocationBuilder(beamLocations: [HomeLocation(), AuthLocation()])
          .call,
  guards: [
    BeamGuard(
      pathPatterns: ['/'],
      check: (context, loaction) {
        return false;
      },
      beamToNamed: (orign, target) => '/auth',
    )
  ],
);

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

class RadishApp extends StatelessWidget {
  const RadishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'Hanbit',
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            labelLarge: TextStyle(color: Colors.white),
          )),
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}

StatelessWidget _splashedLoadingWidget(AsyncSnapshot snapshot) {
  if (snapshot.hasError) {
    print('에러가 발생하였습니다');
    return const Text('error');
  } else if (snapshot.hasData) {
    return const RadishApp();
  } else {
    return const SplashScreen();
  }
}
