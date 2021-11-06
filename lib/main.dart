
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:serow/controllers/menu_controller.dart';
import 'package:serow/controllers/navigation_controller.dart';
import 'package:serow/layout.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/pages/authentication/authentication_page.dart';
import 'package:serow/pages/inventory/items/items.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/inventory_repository/authentication_provider.dart';
import 'package:serow/repository/user_provider.dart';
import 'package:serow/services/preferences.dart';
import 'package:window_size/window_size.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MenuController());
  Get.put(NavigationController());

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    setWindowTitle("Serow");
    setWindowMinSize(const Size(1280, 760));
    setWindowMaxSize(Size.infinite);

  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // Future<User> getUserData() => UserPreferences().getUser();
    Future<Auth> getUserToken() => UserPreferences().getAuth();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ]
      ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        theme: ThemeData(
          primaryColor: const Color(0xff4b5764),
          primaryColorDark: const Color(0xFF5d5b8c),
          iconTheme: const IconThemeData().copyWith(color: Color(0xFF2fb0b2)),
          textTheme: TextTheme(
            headline2: const TextStyle(
              color: Color(0xff4b5764),
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[300],
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
            ),
            bodyText1: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            bodyText2: TextStyle(
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        navigatorKey: Get.key,
        home: FutureBuilder(
          future: getUserToken(),
          builder: (context, snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.none:
              case  ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if(snapshot.hasError)
                  return Text('Error ${snapshot.error}');
                // else if(snapshot.data[1] != null)
                //   print("Has data");
                else if(snapshot.data.accessToken == null)
                  return AuthenticationPage();
                else
                   UserPreferences().removeUser();
              return AuthenticationPage();
            }
          },
        ),
      ),
    );
  }
  
}

