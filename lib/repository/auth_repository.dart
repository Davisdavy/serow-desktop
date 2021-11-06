import 'package:serow/models/auth/auth.dart';

abstract class AuthRepository{
  //Auth
  Future<Map<String, dynamic>> loginUser(String name, String password);


}