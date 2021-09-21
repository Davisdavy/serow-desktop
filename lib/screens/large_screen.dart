import 'package:flutter/material.dart';
import 'package:serow/helper/local_navigator.dart';
import 'package:serow/widgets/side_menu.dart';
class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SideMenu()
        ),
        Expanded(
          flex: 5,
          child: localNavigator()
        )
      ],
    );
  }
}
