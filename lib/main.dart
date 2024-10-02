import 'package:beamer/beamer.dart';
import 'package:clone_radish_app/router/locations.dart';
import 'package:clone_radish_app/screens/splash_screen.dart';
import 'package:clone_radish_app/screens/start_screen.dart';
import 'package:clone_radish_app/states/user_provider.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final _routerDelegate = BeamerDelegate(
  locationBuilder:
      BeamerLocationBuilder(beamLocations: [HomeLocation(), AuthLocation()])
          .call,
  guards: [
    // BeamGuard(
    //   pathPatterns: ['/auth'],
    //   check: (context, location) {
    //     logger.d(
    //         'Beam guard /auth current location ${Beamer.of(context).currentBeamLocation}');

    //     logger.d(
    //         "BeamGuard is running ${context.watch<UserProvider>().user != null}");
    //     return context.watch<UserProvider>().user != null;
    //   },
    //   beamToNamed: (orign, target) => '/',
    // ),
    BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        logger.d(
            'Beam guard / current location ${Beamer.of(context).currentBeamLocation}');

        logger.d(
            "BeamGuard is running ${context.watch<UserProvider>().user != null}");
        return context.watch<UserProvider>().user != null;
      },
      beamToNamed: (orign, target) => '/auth',
    ),
  ],
);

void main() async {
  Provider.debugCheckInvalidValueType = null;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 900),
              child: _splashedLoadingWidget(snapshot),
            ),
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
              headlineMedium: TextStyle(fontSize: 17, color: Colors.black87),
              headlineSmall: TextStyle(fontSize: 13, color: Colors.black38),
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
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              elevation: 2,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black38,
            )),
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
    return Text('error ${snapshot.error}');
  } else if (snapshot.connectionState == ConnectionState.done) {
    return const RadishApp();
  } else {
    return const SplashScreen();
  }
}
