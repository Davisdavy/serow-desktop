import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/widgets/custom_text.dart';
import 'package:steps_indicator/steps_indicator.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Text"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choice Box"),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('Stateful Dialog'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                  ),
                  child: CustomText(
                    text: "You have a total of 8,567 products.",
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
                                hintText: "Search products",
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
                              barrierLabel: MaterialLocalizations.of(context)
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      height:
                                          MediaQuery.of(context).size.height -
                                              120,
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
                                                shadowColor: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: CustomText(
                                                    text: "Add Product",
                                                    size: 22,
                                                    color: Colors.blueGrey,
                                                    weight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                "assets/icons/cancel.svg",
                                                color: Colors.blueGrey,
                                                height: 16,
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
                                            height: 15,
                                          ),
                                          StepsIndicator(
                                            selectedStep: 1,
                                            nbSteps: 3,
                                            //selectedStepColorIn: primaryColor,
                                            selectedStepColorIn:
                                                Colors.grey.withOpacity(0.2),
                                            selectedStepColorOut: Colors.grey,
                                            doneStepColor: primaryColor,
                                            unselectedStepColorIn:
                                                Colors.grey.withOpacity(0.2),
                                            unselectedStepColorOut: Colors.grey,
                                            doneLineColor: primaryColor,
                                            //selectedStepBorderSize: 1,
                                            undoneLineColor: Colors.grey,
                                            isHorizontal: true,
                                            lineLength: 200,
                                            enableLineAnimation: true,
                                            enableStepAnimation: true,
                                            //: Material(child: Center(child: Text("Finish"),)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Material(
                                                child: Text(
                                                  "Details",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Material(
                                                child: Text(
                                                  "Pricing",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Material(
                                                child: Text(
                                                  "Finish",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Material(
                                                child: CustomText(
                                              text:
                                                  "Enter product details to create account.",
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
                                                        "Product Name",
                                                        style: TextStyle(
                                                            color: bgColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "Product Name",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  12),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors
                                                                                  .grey,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
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
                                                        "Product ID",
                                                        style: TextStyle(
                                                            color: bgColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "Product ID",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  12),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors
                                                                                  .grey,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
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
                                                        "Expiry Date",
                                                        style: TextStyle(
                                                            color: bgColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "Expiry Date",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  12),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors
                                                                                  .grey,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5))),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Material(
                                                        child: Text(
                                                      "Quantity",
                                                      style: TextStyle(
                                                          color: bgColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                            decoration:
                                                                InputDecoration(
                                                                    //  labelText: "Email Address",
                                                                    hintText:
                                                                        "Quantity",
                                                                    hintStyle:
                                                                        TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                primaryColor,
                                                                            width:
                                                                                0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                                0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5))),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                                        "Supplier",
                                                        style: TextStyle(
                                                            color: bgColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
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
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      suffixIcon:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                                .all(
                                                                            14.0),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "assets/icons/chevron.svg",
                                                                          color: Colors
                                                                              .blueGrey,
                                                                          width: 10,
                                                                        ),
                                                                      ),
                                                                      hintText:
                                                                          "GSK LTD",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  12),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors
                                                                                  .grey,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5))),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Material(
                                                        child: Text(
                                                      "Category",
                                                      style: TextStyle(
                                                          color: bgColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                            decoration:
                                                                InputDecoration(
                                                                    //
                                                                    suffixIcon:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          14.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "assets/icons/chevron.svg",
                                                                        color: Colors
                                                                            .blueGrey,
                                                                        width: 10,
                                                                      ),
                                                                    ),
                                                                    hintText:
                                                                        "PainKiller",
                                                                    hintStyle:
                                                                        TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                primaryColor,
                                                                            width:
                                                                                0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                                0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5))),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Material(
                                                    child: Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Container(
                                                  width: 492,
                                                  height: 90,
                                                  child: Material(
                                                    child: Flexible(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        minLines: 8,
                                                        //Normal textInputField will be displayed
                                                        maxLines: 8,
                                                        // when user presses enter it will adapt to
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Description",
                                                            hintStyle: TextStyle(
                                                                fontSize: 12),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            primaryColor,
                                                                        width:
                                                                            0.4),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Material(
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: secondaryColor),
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset("assets/icons/cancel.svg", color: secondaryColor, height: 10,),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color: secondaryColor,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Material(
                                                  child: Container(
                                                    height: 40,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                          "Add Product",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                          width: 180,
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
                                "Add Product",
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
          // Flexible(
          //     child: ListView(
          //       shrinkWrap: true,
          //       scrollDirection: Axis.vertical,
          //       children: [
          //         AvailableProducts()
          //       ],
          //     )
          // ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(
                        label: Text(
                      'Products',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                    )),
                    DataColumn(
                        label: Text('Supplier',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14))),
                    DataColumn(
                        label: Text('Inventory',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14))),
                    DataColumn(
                        label: Text('Price',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14))),
                    DataColumn(
                        label: Text('Sales',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14))),
                    DataColumn(
                        label: Text('Status',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14))),
                    DataColumn(
                        label: Icon(
                      Icons.more_horiz,
                      color: Colors.blueGrey,
                    )),
                  ],
                  //source: null,
                  source: _DataSource(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
    //this.valueH
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
      _Row('', '', '', '', ' ', '', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('', '', '', '', ' ', '', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('', '', '', '', ' ', '', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('', '', '', '', ' ', '', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
      _Row('Daniel Kimeli', 'Ksh 23,978.98', '+254723556706', 'Male',
          '09 June 2021', 'Active', Icons.more_horiz),
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
          children: [Text(row.valueA), Text(row.valueA)],
        )),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        DataCell(Icon(row.valueG)),
        // DataCell(Text(row.valueH))
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
