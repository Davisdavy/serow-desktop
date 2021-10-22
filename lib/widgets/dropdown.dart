import 'package:flutter/material.dart';
import 'package:serow/controllers/groups_controller.dart';
import 'package:serow/respository/inventory_repository/groups_inventory_repository.dart';

class DropDownSelect extends StatefulWidget {
  const DropDownSelect({Key key}) : super(key: key);

  @override
  _DropDownSelectState createState() => _DropDownSelectState();
}

class _DropDownSelectState extends State<DropDownSelect> {
  String groupId;
  @override
  Widget build(BuildContext context) {
    var groupsController = GroupsController(GroupsInventoryRepository());
    return FutureBuilder(
      future: groupsController.fetchGroupsList(context),
      builder: (BuildContext context, AsyncSnapshot snap){
        return DropdownButton(
          value: groupId,
          items: snap.data.map((item){
            return new DropdownMenuItem(child: Text(
              item.name,
            ),
                value: item.id.toString()
            );
          }).toList(),
          onChanged: (String newValue){
            setState(() {
              groupId = newValue;
              print(groupId.toString());
            });
          },
        );
      },
    );
  }
}
