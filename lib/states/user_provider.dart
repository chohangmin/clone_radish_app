import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = false;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;

    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}
