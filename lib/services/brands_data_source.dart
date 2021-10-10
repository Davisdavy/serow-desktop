import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/brands_controller.dart';
import 'package:serow/models/inventory/brands.dart';
import 'package:http/http.dart' as http;
import 'package:serow/respository/brands_repository.dart';

typedef OnRowSelect = void Function(int index);

class ResultDataSource extends  DataTableSource{
  //Dependency injection
  var brandsController = BrandsController(BrandsRepository());
  ResultDataSource({
    @required List<Result> resultData,
    @required this.onRowSelect,
     this.callback,
  })  : _resultData = resultData,
        assert(resultData != null);

  final List<Result> _resultData;
  final OnRowSelect onRowSelect;
  //final Function onPressed;
  final Function callback;

  Future<Result> deleteBrand(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://serow.herrings.co.ke/api/v1/inventory/brands/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMzNzk0Njg3LCJqdGkiOiIzOGVlNTdiYjhmNjU0OTUzYWIxZjdkYzg5NWNhZTMxNyIsInVzZXJfaWQiOiI3MzkyMDhhMC1mMzRjLTQ5ZWEtYjNlNC0yMWU3OGFmZWRkZDQifQ.hRYGqBsF-5Egc2DOycC_qI0sVXaacj6IUtcQBLK2IPo",
      },
    );

    if (response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete brand.');
    }
  }

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
        DataCell(Text('${_result.country}',style: TextStyle(fontSize: 13.0, color: secondaryColor))),
        DataCell(Text('${_result.isActive.toString() == "true" ? "Active" : "Inactive"}',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: primaryColor),)),

        DataCell(
            PopupMenuButton(
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


                  onTap: () {
                    print("************************${_result.id}");
    // setState(() {
    // _futureResult =

    deleteBrand(_result.id.toString());
    // });
    // },
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/garbage.svg", height: 18.0,color: Colors.blueGrey, ),
                      SizedBox(width:10.0),
                      Text("Delete", style: TextStyle(color: Colors.blueGrey, fontSize: 13.0),)
                    ],
                  ),
                  value: 4,
                ),
              ],
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