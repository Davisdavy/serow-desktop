import 'package:flutter/material.dart';
import 'package:serow/screens/sidemenu/serow-side-menu.dart';

import '../../constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          SerowSideMenu(),
          Expanded(
              flex: 5,
              child: Container(
                color: bgColor,
              ))
        ],
      )),
    );
  }
}
