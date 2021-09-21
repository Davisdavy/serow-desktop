import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';

import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  const HorizontalMenuItem({ Key? key, required this.itemName, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: () => onTap,
        onHover: (value){
          value ?
          menuController.onHover(itemName) : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
          color: menuController.isHovering(itemName) ? Colors.grey.withOpacity(.1) : Colors.transparent,
          child: Row(
            children: [
              // Visibility(
              //   visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
              //   maintainSize: true,
              //   maintainAnimation: true,
              //   maintainState: true,
              //   child: Container(
              //     width: 6,
              //     height: 40,
              //     color: primaryColor,
              //   ),
              // ),
              SizedBox(width:_width / 88),

              Padding(
                padding: const EdgeInsets.all(16),
                child: menuController.returnIconFor(itemName),
              ),
              if(!menuController.isActive(itemName))
                Flexible(child: CustomText(text: itemName , color: menuController.isHovering(itemName) ? primaryColor : bgColor,))
              else
                Flexible(child: CustomText(text: itemName , color:  primaryColor , size: 18, weight: FontWeight.bold,))

            ],
          ),
        ))
    );
  }
}