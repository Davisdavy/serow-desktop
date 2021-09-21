import 'package:flutter/material.dart';
import 'package:serow/helper/local_navigator.dart';
import 'package:serow/widgets/side_menu.dart';
class LargeScreen extends StatefulWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex:2,
          child: SideMenu()
        ),
        Expanded(
          flex: 8,
          child: localNavigator()
        )
      ],
    );
  }
}
