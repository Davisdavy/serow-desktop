
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
     appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(largeScreen: LargeScreen(),)

    );
  }
}