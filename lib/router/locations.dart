import 'package:beamer/beamer.dart';
import 'package:clone_radish_app/screens/auth_screen.dart';
import 'package:clone_radish_app/screens/home_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [const BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  List<Pattern> get pathPatterns => ['/'];
}

class AuthLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [const BeamPage(child: AuthScreen(), key: ValueKey('auth'))];
  }

  @override
  List<Pattern> get pathPatterns => ['/auth'];
}
