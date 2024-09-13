import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = false;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;

    // if (authState) {
    //   Beamer.of(context).beamToNamed('/');
    // } else {}
    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}
