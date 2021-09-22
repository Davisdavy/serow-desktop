import 'package:flutter/material.dart';
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
        Expanded(
           child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        PaginatedDataTable(
        rowsPerPage: 4,
        columns: [
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Ordered')),
        DataColumn(label: Text('Phone Number')),
        DataColumn(label: Text('Gender')),
          DataColumn(label: Text('Last Order')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Icon(Icons.more_horiz)),
        ],
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
      this.valueG,


      );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;
  final IconData valueG;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male','09 June 2021', 'Active', Icons.more_horiz ),

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
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        DataCell(Icon(row.valueG)),
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
