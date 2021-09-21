import 'package:flutter/material.dart';
import 'package:serow/constants.dart';
import 'package:serow/widgets/custom_text.dart';
class SuppliersPage extends StatelessWidget {
  const SuppliersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text:"Suppliers", color: secondaryColor,),
    );
  }
}
