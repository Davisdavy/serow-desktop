import 'package:flutter/material.dart';

class SerowMenuTitle extends StatelessWidget {
  const SerowMenuTitle({
    Key? key,
     this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title!,
        style: TextStyle(color: Colors.black54),
        textAlign: TextAlign.left,
      ),
    );
  }
}
