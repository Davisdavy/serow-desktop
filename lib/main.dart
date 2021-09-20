
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/widgets/widgets.dart';
import 'package:window_size/window_size.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isWindows || Platform.isLinux || Platform.isMacOS ){
  //   setWindowMinSize(Size(942.0, 1050.0));
  //   setWindowMaxSize(Size(942.0, 1050.0));
  //   setWindowTitle("Serow");
  // }
  // if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
  //   await DesktopWindow.setMinWindowSize(const Size(600, 700));
  //   setWindowTitle("Serow POS");
  // }
  Get.put(SideMenu());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
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
      home: Shell(),
    );
  }
}

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //side menu
                SideMenu(),
                //Main section(details,etc)
                Expanded(
                  child: Container(
                    color: Color(0xFFf5f6fa),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        HeaderMenu(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
