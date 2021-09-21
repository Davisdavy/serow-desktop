
import 'package:flutter/material.dart';
import 'package:serow/responsive.dart';
import 'package:serow/screens/large_screen.dart';
import 'package:serow/widgets/side_menu.dart';
import 'package:serow/widgets/top_nav.dart';

class Layout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body:LargeScreen(),
      floatingActionButton: Stack(
        children:[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top:18.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.27,
                height: 60,
                child: Container(
                child: topNavigationBar(context, scaffoldKey),
        ),
              ),
            ),
          ),]
      ),
    );
  }
}