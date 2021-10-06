
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/controllers/menu_controller.dart';
import 'package:serow/controllers/navigation_controller.dart';
import 'package:serow/pages/authentication/authentication_page.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: AuthenticationPage(),
    );
  }
}
//
// class Shell extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //side menu
//                 SideMenu(),
//                 //Main section(details,etc)
//                 Expanded(
//                   child: Container(
//                     color: Color(0xFFf5f6fa),
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: Column(
//                       children: [
//                         HeaderMenu(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
