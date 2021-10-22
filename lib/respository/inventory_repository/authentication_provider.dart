import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/respository/auth_repository.dart';
import 'package:serow/services/preferences.dart';
import 'package:serow/services/services.dart';
import 'dart:convert';
enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthenticationProvider with ChangeNotifier implements AuthRepository{
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  @override
  Future<Map<String, dynamic>> loginUser(String name, String password) async{
    var result;
    _loggedInStatus = Status.Authenticating;
    notifyListeners();


    Response response = await post(
      Uri.parse(AppUrl.login),
      body: jsonEncode(<dynamic, String>{
        'username_email': name,
        'password': password,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );


    if (response.statusCode == 200) {
      print("OKAY");
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;
      Auth authUser = Auth.fromJson(userData);

      UserPreferences().saveUser(authUser);
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    }else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;

  }

  
}