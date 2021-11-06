
import 'package:flutter/foundation.dart';
import 'package:serow/models/auth/auth.dart';

class AuthProvider with ChangeNotifier {
  Auth _auth = new Auth();

  Auth get auth => _auth;


  void setAuth(Auth auth) {
    _auth = auth;
    notifyListeners();
  }
}