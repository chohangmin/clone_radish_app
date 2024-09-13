import 'package:beamer/beamer.dart';
import 'package:clone_radish_app/router/locations.dart';
import 'package:clone_radish_app/screens/splash_screen.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
  locationBuilder:
      BeamerLocationBuilder(beamLocations: [HomeLocation(), AuthLocation()])
          .call,
  guards: [
    BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        logger.d('current location ${Beamer.of(context).currentBeamLocation}');

        logger.d(
            "BeamGuard is running ${context.watch<UserProvider>().userState}");
        return context.watch<UserProvider>().userState;
      },
      beamToNamed: (orign, target) => '/auth',
    ),
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
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'Hanbit',
          hintColor: Colors.grey[350],
          primaryColor: Colors.pink[300],
          textTheme: const TextTheme(
            labelLarge: TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.pink[300],
              foregroundColor: Colors.white,
              minimumSize: const Size(48, 48),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black87),
            elevation: 2,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
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
