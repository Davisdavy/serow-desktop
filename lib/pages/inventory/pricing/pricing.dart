import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/models/inventory/brands.dart';
import 'package:serow/services/locations_data_source.dart';
import 'package:serow/services/pricing_data_source.dart';
import 'package:serow/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class PricingPage extends StatefulWidget {
  const PricingPage({Key key}) : super(key: key);

  @override
  State<PricingPage> createState() => _PricingPageState();
}


class _PricingPageState extends State<PricingPage> {
  List<Result> listResult = [];
  List brandCount = [];
  var loading = false;
  double pageCount = 0;
  bool showLoadingIndicator = false;
  bool valuefirst = false;
  bool valuesecond = false;

  Future<Null> getResults() async {
    setState(() {
      loading = true;
    });
    final responseData = await http.get(
      Uri.parse("https://serow.herrings.co.ke/api/v1/inventory/brands"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMzNjkwNTY2LCJqdGkiOiIwNGM1NDA1MzQ2NmE0ZWRiODU1YjVlNWY0NzZiMDE0MiIsInVzZXJfaWQiOiI3MzkyMDhhMC1mMzRjLTQ5ZWEtYjNlNC0yMWU3OGFmZWRkZDQifQ.Is_cliJpxCjDhKNd9hcEdX-W9jrYTLneMa_07axZUHk"
      },
    );
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      print(data["results"]);
      setState(() {
        for (Map<String, dynamic> i in data["results"]) {
          listResult.add(Result.fromJson(i));
        }
        loading = false;
      });
    }
  }

  Future<Brands> createBrands(String name, String shortName,
      String country) async {
    final response = await http.post(
      Uri.parse("https://serow.herrings.co.ke/api/v1/inventory/brands/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMzNjkwNTY2LCJqdGkiOiIwNGM1NDA1MzQ2NmE0ZWRiODU1YjVlNWY0NzZiMDE0MiIsInVzZXJfaWQiOiI3MzkyMDhhMC1mMzRjLTQ5ZWEtYjNlNC0yMWU3OGFmZWRkZDQifQ.Is_cliJpxCjDhKNd9hcEdX-W9jrYTLneMa_07axZUHk"
      },
      body: jsonEncode(<dynamic, String>{
        'name': name,
        'short_name': shortName,
        'country': ''
      }),
    );
    if (response.statusCode == 201) {
      print("Success***********");
      return brandsFromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to create brand');
    }
  }


  @override
  void initState() {
    super.initState();
    getResults();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<Brands> _brandsFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade100.withOpacity(0.1),
        child: Column(
          children: [
            Obx(
                  () =>
                  Row(
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
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60.0,

                    ),
                    child: CustomText(
                      text: "You have a total of 5 pricing.",
                      //ToDo: Read from count method
                      size: 12,
                      color: Colors.blueGrey,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                        child: Container(
                          width: 180,
                          height: 40,
                          margin: EdgeInsets.only(
                            top: 1,
                            bottom: 15.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300.withOpacity(0.6)),
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
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 10, bottom: 10),
                                    child: Image.asset(
                                      "assets/icons/search.png",
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Search pricing",
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
                        child: Container(
                          width: 100,
                          height: 40,
                          margin: EdgeInsets.only(
                            top: 1,
                            bottom: 15.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300.withOpacity(0.6)),
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
                                    padding: const EdgeInsets.only(
                                        right: 1.0, top: 10, bottom: 10),
                                    child: SvgPicture.asset(
                                      "assets/icons/chevron.svg",
                                      color: Colors.blueGrey,
                                      width: 10,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Filter",
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: InkWell(
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations
                                    .of(context)
                                    .modalBarrierDismissLabel,
                                barrierColor: Colors.black45,
                                transitionDuration:
                                const Duration(milliseconds: 200),
                                pageBuilder: (BuildContext buildContext,
                                    Animation animation,
                                    Animation secondaryAnimation) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                          color: Colors.white,
                                        ),
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width / 2.4,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height -
                                            400,
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Material(
                                                  shadowColor: Colors
                                                      .transparent,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 18.0),
                                                    child: CustomText(
                                                      text: "Add Pricing",
                                                      size: 22,
                                                      color: Colors.blueGrey,
                                                      weight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      _nameController.clear();
                                                      _countryController
                                                          .clear();
                                                      _shortNameController
                                                          .clear();
                                                      Navigator.of(context,
                                                          rootNavigator: true)
                                                          .pop();
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/icons/cancel.svg",
                                                      color: Colors.blueGrey,
                                                      height: 16,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.grey.shade200,
                                              height: 5.0,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 12.0),
                                              child: Material(
                                                  child: CustomText(
                                                    text:
                                                    "Enter details to create pricing.",
                                                    size: 11.0,
                                                    color: Colors.blueGrey,
                                                    weight: FontWeight.w500,
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                        child: Material(
                                                            child: Text(
                                                              "Pricing formula",
                                                              style: TextStyle(
                                                                  color: bgColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Material(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                          child: Container(
                                                            width: 240,
                                                            height: 40,
                                                            child: Flexible(
                                                              child: TextField(
                                                                controller: _nameController,
                                                                decoration:
                                                                InputDecoration(
                                                                  //  labelText: "Email Address",
                                                                    errorText: _validate
                                                                        ? 'formula can\'t Be Empty'
                                                                        : null,
                                                                    hintText:
                                                                    "Formula",
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                            primaryColor,
                                                                            width:
                                                                            0.4),
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            5)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                            0.4),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            5))),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                        child: Material(
                                                            child: Text(
                                                              "Formula name",
                                                              style: TextStyle(
                                                                  color: bgColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Material(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                          child: Container(
                                                            width: 240,
                                                            height: 40,
                                                            child: Flexible(
                                                              child: TextField(
                                                                controller: _shortNameController,
                                                                decoration:
                                                                InputDecoration(
                                                                  //  labelText: "Email Address",
                                                                  //errorText: _validate ? ' Can\'t Be Empty' : null,
                                                                    hintText:
                                                                    "Example: ...",
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                            primaryColor,
                                                                            width:
                                                                            0.4),
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            5)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                            0.4),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            5))),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Material(
                                                      child: InkWell(
                                                        onTap: () {
                                                          _nameController
                                                              .clear();
                                                          _countryController
                                                              .clear();
                                                          _shortNameController
                                                              .clear();
                                                          Navigator.of(context,
                                                              rootNavigator: true)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                secondaryColor),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                5.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              SvgPicture
                                                                  .asset(
                                                                "assets/icons/cancel.svg",
                                                                color:
                                                                secondaryColor,
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: 8.0,
                                                              ),
                                                              Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color:
                                                                    secondaryColor,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Material(
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _nameController.text
                                                                .isEmpty
                                                                ?
                                                            _validate = true
                                                                : _validate =
                                                            false;
                                                            _shortNameController.text.isEmpty ? _validate = true : _validate = false;
                                                            _countryController
                                                                .text.isEmpty
                                                                ?
                                                            _validate = true
                                                                : _validate =
                                                            false;
                                                            //createBrands(_nameController.text, _shortNameController.text, _countryController.text);
                                                            Navigator.of(context, rootNavigator: true).pop();
                                                            //  getResults();
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 150,
                                                          decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                5.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 8.0,
                                                              ),
                                                              Text(
                                                                "Add Pricing",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 40.0,
                            width: 150,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "Add Pricing",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            SingleChildScrollView(
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  Theme(

                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.blueGrey.shade100.withOpacity(0.4),
                    ),
                    child: PaginatedDataTable(
                      rowsPerPage: listResult.length,
                      showCheckboxColumn: true,
                      dataRowHeight: 60,
                      columns: [
                        DataColumn(label: Text(
                          "Formula",
                          style: TextStyle(
                              fontSize: 13.5,
                              color: secondaryColor.withOpacity(0.4)),
                        ),),
                        DataColumn(label: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 13.5,
                              color: secondaryColor.withOpacity(0.4)),
                        ),),
                        DataColumn(label: Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 13.5,
                              color: secondaryColor.withOpacity(0.4)),
                        ),),
                        DataColumn(label: PopupMenuButton(
                          elevation: 20.0,
                          icon: Icon(
                            Icons.more_horiz,
                            color: secondaryColor.withOpacity(0.5),
                          ),
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/view.svg", height: 18.0,
                                    color: Colors.blueGrey,),
                                  SizedBox(width: 10.0),
                                  Text("View Details", style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 13.0),)
                                ],
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/repeat.svg", height: 18.0,
                                    color: Colors.blueGrey,),
                                  SizedBox(width: 10.0),
                                  Text("Orders", style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 13.0),)
                                ],
                              ),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/activities.svg", height: 18.0,
                                    color: Colors.blueGrey,),
                                  SizedBox(width: 10.0),
                                  Text("Activities", style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 13.0),)
                                ],
                              ),
                              value: 3,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/garbage.svg", height: 18.0,
                                    color: Colors.blueGrey,),
                                  SizedBox(width: 10.0),
                                  Text("Delete", style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 13.0),)
                                ],
                              ),
                              value: 4,
                            ),
                          ],
                        )),
                      ],
                      source: PricingDataSource(
                        onRowSelect: (index) => () {},
                        resultData: listResult,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],)
    );
  }
}