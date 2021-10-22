import 'package:flutter/foundation.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;


  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}