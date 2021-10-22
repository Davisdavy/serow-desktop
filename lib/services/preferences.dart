
import 'package:serow/models/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
Future<bool> saveUser(Auth user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if(user != null){
    prefs.setString("id", user.user.id);
    prefs.setString("first_name", user.user.firstName);
    prefs.setString("last_name", user.user.lastName);
    prefs.setString("profile", user.user.profile);
    prefs.setString("full_name",user.user.fullName);
    prefs.setString("phone",user.user.phone);
    prefs.setString("role", user.user.role);
    prefs.setString("access_token", user.accessToken);
    prefs.setString("refresh_token", user.refreshToken);
    return true;
  }


  return false;
}
// Future<bool> saveUserToken(Auth auth)async{
//   final SharedPreferences prefs= await SharedPreferences.getInstance();
//   if(auth != null){
//     prefs.setString("access_token", auth.accessToken);
//     prefs.setString("refresh_token", auth.refreshToken);
//     return true;
//   }
//   else {
//     return false;
//   }
// }
Future<User> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String id = prefs.getString("id");
  String firstName = prefs.getString("first_name");
  String lastName = prefs.getString("last_name");
  String profile = prefs.getString("profile");
  String full_name = prefs.getString("full_name");
  String email = prefs.getString("email");
  String phone = prefs.getString("phone");
  String role = prefs.getString("role");


  return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      profile: profile,
      fullName: full_name,
      email: email,
      phone: phone,
    role: role,

      );
}

Future<Auth> getAuth() async {
  final SharedPreferences prefsAuth = await SharedPreferences.getInstance();
  String access_token = prefsAuth.getString("access_token");
  String refresh_token = prefsAuth.getString("refresh_token");
  return Auth(
    accessToken: access_token,
    refreshToken: refresh_token,
  );
}

void removeUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove("first_name");
  prefs.remove("last_name");
  prefs.remove("email");
  prefs.remove("phone");
  prefs.remove("role");
  prefs.remove("access_token");
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String access_token = prefs.getString("access_token");
  return access_token;
}
}