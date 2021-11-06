import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/forms_controller.dart';
import 'package:serow/models/inventory/forms.dart';
import 'package:serow/repository/inventory_repository/forms_inventory_repository.dart';

typedef OnRowSelect = void Function(int index);

class FormsDataSource extends  DataTableSource{
  //Dependency injection
  var formsController = FormsController(FormsInventoryRepository());
  FormsDataSource({
    @required List<Results> resultData,
    @required this.onRowSelect,
  })  : _resultData = resultData,
        assert(resultData != null);

  final List<Results> _resultData;
  final OnRowSelect onRowSelect;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _resultData.length) {
      return null;
    }
    final _result = _resultData[index];

    return DataRow.byIndex(

      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_result.name}',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: secondaryColor))),
        DataCell(Text('${_result.shortName}',style: TextStyle(fontSize: 13.0, color: secondaryColor))),
        DataCell(Text('${_result.isActive.toString() == "true" ? "Active" : "Inactive"}',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: primaryColor),)),

        DataCell(
            Builder(
              builder: (newContext) {
                return FutureBuilder<List<Results>>(
                  future: formsController.fetchFormsList(newContext),
                  builder: (context, snapshot){
                    return PopupMenuButton(
                      elevation: 20.0,
                      icon: Icon(
                        Icons.more_horiz,
                        color: secondaryColor.withOpacity(0.5),
                      ),
                      itemBuilder: (context) =>[
                        PopupMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/view.svg", height: 18.0,color: Colors.blueGrey, ),
                              SizedBox(width:10.0),
                              Text("View Details", style: TextStyle(color: Colors.blueGrey, fontSize: 13.0),)
                            ],
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/repeat.svg", height: 18.0,color: Colors.blueGrey, ),
                              SizedBox(width:10.0),
                              Text("Orders", style: TextStyle(color: Colors.blueGrey, fontSize: 13.0),)
                            ],
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/activities.svg", height: 18.0,color: Colors.blueGrey, ),
                              SizedBox(width:10.0),
                              Text("Activities", style: TextStyle(color: Colors.blueGrey, fontSize: 13.0),)
                            ],
                          ),
                          value: 3,
                        ),

                        PopupMenuItem(
                          onTap: ()  {
                            //Here is the delete functionality
                            formsController.deleteForms(_result.id.toString(), newContext);
                          },
                          child:Row(
                            children: [
                              SvgPicture.asset("assets/icons/garbage.svg", height: 18.0,color: Colors.blueGrey, ),
                              SizedBox(width:10.0),
                              Text("Delete", style: TextStyle(color: Colors.blueGrey, fontSize: 13.0),)
                            ],
                          ),
                          value: 4,
                        ),
                      ],
                    );
                  },
                );
              }
            )
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _resultData.length;
  @override
  int get selectedRowCount => 0;
}

