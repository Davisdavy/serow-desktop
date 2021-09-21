import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:serow/constants.dart';
import 'package:serow/data/data_source.dart';


class AvailableProducts extends StatefulWidget {


  @override
  _AvailableProductsState createState() => _AvailableProductsState();
}

class _AvailableProductsState extends State<AvailableProducts>
    with RestorationMixin {
  final RestorableDessertSelections _dessertSelections =
  RestorableDessertSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage =
  RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
   DessertDataSource _dessertsDataSource;
  bool initialized = false;

  @override
  String get restorationId => 'paginated_data_table_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_dessertSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');
    registerForRestoration(_sortAscending, 'sort_ascending');
    registerForRestoration(_sortColumnIndex, 'sort_column_index');

    if (!initialized) {
      _dessertsDataSource = DessertDataSource(context);
      initialized = true;
    }
    switch (_sortColumnIndex.value) {
      case 0:
        _dessertsDataSource.sort<String>((d) => d.name, _sortAscending.value);
        break;
      case 1:
        _dessertsDataSource.sort<num>((d) => d.calories, _sortAscending.value);
        break;
      case 2:
        _dessertsDataSource.sort<num>((d) => d.fat, _sortAscending.value);
        break;
      case 3:
        _dessertsDataSource.sort<num>((d) => d.carbs, _sortAscending.value);
        break;
      case 4:
        _dessertsDataSource.sort<num>((d) => d.protein, _sortAscending.value);
        break;
      case 5:
        _dessertsDataSource.sort<num>((d) => d.sodium, _sortAscending.value);
        break;
      case 6:
        _dessertsDataSource.sort<num>((d) => d.calcium, _sortAscending.value);
        break;
    }
    _dessertsDataSource.updateSelectedDesserts(_dessertSelections);
    _dessertsDataSource.addListener(_updateSelectedDessertRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      _dessertsDataSource = DessertDataSource(context);
      initialized = true;
    }
    _dessertsDataSource.addListener(_updateSelectedDessertRowListener);
  }

  void _updateSelectedDessertRowListener() {
    _dessertSelections.setDessertSelections(_dessertsDataSource.desserts);
  }

  void sort<T>(
      Comparable<T> Function(Dessert d) getField,
      int columnIndex,
      bool ascending,
      ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _sortColumnIndex.dispose();
    _sortAscending.dispose();
    _dessertsDataSource.removeListener(_updateSelectedDessertRowListener);
    _dessertsDataSource.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      restorationId: 'paginated_data_table_list_view',
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   border: Border.all(color: secondaryColor.withOpacity(.4), width: .5),
          //   boxShadow: [
          //     BoxShadow(
          //         offset: Offset(0, 6),
          //         color: secondaryColor.withOpacity(.1),
          //         blurRadius: 12)
          //   ],
          //   borderRadius: BorderRadius.circular(8),
          // ),
          child: PaginatedDataTable(
            rowsPerPage: _rowsPerPage.value,
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage.value = value;
              });
            },
            initialFirstRowIndex: _rowIndex.value,
            onPageChanged: (rowIndex) {
              setState(() {
                _rowIndex.value = rowIndex;
              });
            },
            sortColumnIndex: _sortColumnIndex.value,
            sortAscending: _sortAscending.value,
            onSelectAll: _dessertsDataSource.selectAll,
            columns: [
              DataColumn2(
                label: Text('Product'),
                size: ColumnSize.S,
                onSort: (columnIndex, ascending) =>
                    sort<String>((d) => d.name, columnIndex, ascending),
              ),
              DataColumn2(
                label: Text('Supplier'),
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    sort<num>((d) => d.calories, columnIndex, ascending),
              ),
              DataColumn2(
                label: Text('Inventory'),
                numeric: true,

                onSort: (columnIndex, ascending) =>
                    sort<num>((d) => d.fat, columnIndex, ascending),
              ),
              DataColumn2(
                label: Text('Price'),
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    sort<num>((d) => d.carbs, columnIndex, ascending),
              ),
              DataColumn2(
                label: Text('Sales'),
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    sort<num>((d) => d.protein, columnIndex, ascending),
              ),
              DataColumn2(
                label: Text('Status'),
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    sort<num>((d) => d.sodium, columnIndex, ascending),
              ),
              DataColumn2(
                label: Icon(Icons.more_horiz),
                // numeric: true,
                // onSort: (columnIndex, ascending) =>
                //     sort<num>((d) => d.calcium, columnIndex, ascending),
              ),

            ],
            source: _dessertsDataSource,
          ),
        ),
      ],
    );
  }
}
