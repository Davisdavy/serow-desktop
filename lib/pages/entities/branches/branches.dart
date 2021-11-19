import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/branches_controller.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/cost_centers_controller.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/repository/accounts_repository/cost_centers_accounts_repository.dart';
import 'package:serow/repository/entities_repository/branches_entities_repository.dart';
import 'package:serow/services/branches_data_source.dart';
import 'package:serow/widgets/custom_text.dart';


class BranchesPage extends StatefulWidget {
  const BranchesPage({Key key}) : super(key: key);

  @override
  _BranchesPageState createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String costCenterId;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  void updateUI(){
    setState(() {
      //Refresh page
    });
  }
  @override
  Widget build(BuildContext context) {
    var branchesController = BranchesController(BranchesEntitiesRepository());
    var costCenterController = CostCentersController(CostCentersAccountsRepository());
    return Container(
        color: Colors.blueGrey.shade100.withOpacity(0.1),
        child: Column(
            children: [
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

              SingleChildScrollView(
                child: FutureBuilder(
                  future: Future.wait<Object>([
                    branchesController.fetchBranchList(context),
                    costCenterController.fetchCostCenterList(context),
                  ]),

                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.hasError){
                        print("Error: ${snapshot.error}");
                        return Column(
                          children: [
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
                                      text: "You have a total of 5 branches.",
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
                                                  hintText: "Search branches",
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
                                                  "Add Branch",
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
                            Center(
                              child: Text("Error"),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
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
                                    text: "You have a total of 5 branches.",
                                    //ToDo: Read from count method
                                    size: 12,
                                    color: Colors.blueGrey,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    updateUI();
                                  },
                                  child: CustomText(
                                    text: "Refresh",
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
                                                hintText: "Search branches",
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
                                              barrierDismissible: false ,
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
                                                          300,
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
                                                                    text: "Add Branch",
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
                                                                    _phoneController
                                                                        .clear();
                                                                    _locationController
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
                                                                  "Enter details to create branch.",
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
                                                                            "Branch Name",
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
                                                                                //   errorText: _validate
                                                                                //       ? 'Name Can\'t Be Empty'
                                                                                //       : null,
                                                                                  hintText:
                                                                                  "Branch Name",
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
                                                                            "Location",
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
                                                                              controller: _locationController,
                                                                              decoration:
                                                                              InputDecoration(
                                                                                //  labelText: "Email Address",
                                                                                //errorText: _validate ? ' Can\'t Be Empty' : null,
                                                                                  hintText:
                                                                                  "Example: Kenya",
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
                                                                            "Phone",
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
                                                                              controller: _phoneController,

                                                                              decoration:
                                                                              InputDecoration(
                                                                                  hintText:
                                                                                  "Phone",
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
                                                                            "Select Cost Center",
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
                                                                            child: StatefulBuilder(
                                                                              builder: (BuildContext context, StateSetter setState){
                                                                                return DecoratedBox(

                                                                                  decoration: ShapeDecoration(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        side: BorderSide(width: 0.4, style: BorderStyle.solid, color: Colors.grey),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                                      )
                                                                                  ),
                                                                                  child: DropdownButtonHideUnderline(
                                                                                    child: DropdownButton<String>(
                                                                                      hint: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text("Cost Center", style: TextStyle(fontSize:
                                                                                        12),),
                                                                                      ),
                                                                                      value: costCenterId,
                                                                                      items: snapshot.data[1].map<DropdownMenuItem<String>>((item){
                                                                                        return new DropdownMenuItem<String>(child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(
                                                                                            item.quantity,
                                                                                            style: TextStyle(fontSize:
                                                                                            12,),
                                                                                          ),
                                                                                        ),
                                                                                            value: item.id.toString()
                                                                                        );
                                                                                      }).toList(),
                                                                                      onChanged: (String groupValue){
                                                                                        setState(() {
                                                                                          costCenterId = groupValue;

                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
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
                                                                        _nameController.clear();
                                                                        _phoneController
                                                                            .clear();
                                                                        _locationController
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
                                                                      onTap: ()  {
                                                                        if(_nameController.value.text.isNotEmpty && _locationController.value.text.isNotEmpty){
                                                                          branchesController.postBrand(_nameController.text, _locationController.text, _phoneController.text, context);
                                                                          setState(() {
                                                                            _nameController.clear();
                                                                            _phoneController
                                                                                .clear();
                                                                            _locationController
                                                                                .clear();
                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                          });
                                                                        } else{
                                                                          null;
                                                                        }

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
                                                                              "Add Branch",
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
                                                "Add Branch",
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
                          ListView(
                            padding: const EdgeInsets.all(16),
                            shrinkWrap: true,
                            children: [
                              Theme(

                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.blueGrey.shade100.withOpacity(0.4),
                                ),
                                child: PaginatedDataTable(
                                  rowsPerPage: snapshot.data.length,
                                  showCheckboxColumn: true,
                                  dataRowHeight: 60,
                                  columns: [
                                    DataColumn(label: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: secondaryColor.withOpacity(0.4)),
                                    ),),
                                    DataColumn(label: Text(
                                      "Location",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: secondaryColor.withOpacity(0.4)),
                                    ),),
                                    DataColumn(label: Text(
                                      "Phone",
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
                                  source: BranchesDataSource(
                                    onRowSelect: (index) => () {},
                                    resultData: snapshot.data[0],

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
        ]));
  }
}
