import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/widgets/custom_text.dart';


class ClientsPage extends StatefulWidget {
  const ClientsPage({Key key}) : super(key: key);

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade100.withOpacity(0.1),
        child: Column(children: [
          Obx(
                () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 90),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 28,
                        color: bgColor,
                        weight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ]));
  }
}
