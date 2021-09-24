import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/widgets/custom_text.dart';
class CustomersPage extends StatelessWidget {
  const CustomersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowSpacer=TableRow(
        children: [
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 8,
          )
        ]);
    return Column(
      children: [
        Obx(
              () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: 90
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:60.0),
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
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:60.0,),
                child: CustomText(
                  text: "You have a total of 2,567 customers.",
                  size: 12,
                  color: Colors.blueGrey,
                  weight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:0.0, bottom: 8.0),
                    child: Container(
                      width: 190,
                      height: 40,
                      margin: EdgeInsets.only(top:1,  bottom: 15.0, ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300.withOpacity(0.6)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                              isDense: false,
                              //prefixIconConstraints: BoxConstraints(minWidth: 10,),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10.0, top:10, bottom: 10 ),
                                child: Image.asset("assets/icons/search.png", ),
                              ),
                              border: InputBorder.none,
                              hintText: "Search customers",
                              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16.0, fontWeight: FontWeight.w400),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.0,),
                  Padding(
                    padding: const EdgeInsets.only(top:0.0, bottom: 8.0),
                    child: Container(
                      width: 120,
                      height: 40,
                      margin: EdgeInsets.only(top:1,  bottom: 15.0, ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300.withOpacity(0.6)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          decoration: InputDecoration(
                              isDense: false,
                              //prefixIconConstraints: BoxConstraints(minWidth: 10,),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 1.0, top:10, bottom: 10 ),
                                child: SvgPicture.asset("assets/icons/chevron.svg", color: Colors.blueGrey, width: 10,),
                              ),
                              border: InputBorder.none,
                              hintText: "Status",
                              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16.0, fontWeight: FontWeight.w400),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.0,),
                  Padding(
                    padding: const EdgeInsets.only(bottom:24.0),
                    child: Container(height: 40.0,
                      width: 180,

                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,color: Colors.white,size: 20,),
                          SizedBox(width: 8.0,),
                          Text("Add Customer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
           child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        PaginatedDataTable(
        rowsPerPage: 1,
        columns: [
        DataColumn(label: Text('Customer', style: TextStyle(color: Colors.blueGrey, fontSize: 14),)),
        DataColumn(label: Text('Ordered', style: TextStyle(color: Colors.blueGrey, fontSize: 14))),
        DataColumn(label: Text('Phone Number', style: TextStyle(color: Colors.blueGrey, fontSize: 14))),
        DataColumn(label: Text('Gender', style: TextStyle(color: Colors.blueGrey, fontSize: 14))),
          DataColumn(label: Text('Last Order', style: TextStyle(color: Colors.blueGrey, fontSize: 14))),
          DataColumn(label: Text('Status', style: TextStyle(color: Colors.blueGrey, fontSize: 14))),
          DataColumn(label: Icon(Icons.more_horiz, color: Colors.blueGrey,)),
        ],
       //source: null,
        source: _DataSource(context),
        ),
        ],
    ),
    ),
    ]);
  }
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD,
      this.valueE,
      this.valueF,
   //   this.valueG,
      this.valueH

      );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;
  //final IconData valueG;
  final String valueH;
  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('', '', '', '',' ', '', '' ),
      //_Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      // _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      // _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      // _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),

    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Column(
          children: [
            Text(row.valueA),
            Text(row.valueA)
          ],
        )),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        //DataCell(Icon(row.valueG)),
        DataCell(Text(row.valueH))
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
