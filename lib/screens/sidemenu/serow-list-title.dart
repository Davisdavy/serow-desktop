import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SerowListTitle extends StatelessWidget {
  const SerowListTitle({
    Key? key,
     this.title,
     this.imageSrc,
     this.press,
  }) : super(key: key);

  final String? title, imageSrc;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: SvgPicture.asset(
        imageSrc!,
        color: Colors.black54,
        height: 15,
        width: 15,
      ),
      horizontalTitleGap: 0.0,
      title: Text(
        title!,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
