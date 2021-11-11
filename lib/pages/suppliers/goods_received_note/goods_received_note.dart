
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/branches_controller.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/goods_received_notes_controller.dart';
import 'package:serow/controllers/supliers_controller.dart';
import 'package:serow/repository/entities_repository/branches_entities_repository.dart';
import 'package:serow/repository/suppliers_repository/goods_received_notes_supliers_repository.dart';
import 'package:serow/repository/suppliers_repository/suppliers_provider.dart';
import 'package:serow/services/goods_received_notes_data_source.dart';
import 'package:serow/widgets/custom_text.dart';
import 'package:serow/widgets/step_progress.dart';

class GoodsReceivedNotePage extends StatefulWidget {
  const GoodsReceivedNotePage({Key key}) : super(key: key);

  @override
  State<GoodsReceivedNotePage> createState() => _GoodsReceivedNotePageState();
}


class _GoodsReceivedNotePageState extends State<GoodsReceivedNotePage> {
  String branchId;
  String supplierId;
  double pageCount = 0;
  String posting_category_id;
  List<String> supplierContact = [];
  PageController controller = PageController();
  final _stepsText = ["General details", "Item details"];

  final _stepCircleRadius = 3.0;

  final _stepProgressViewHeight = 20.0;

  Color _activeColor = primaryColor;

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle =
  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  Size _safeAreaSize;

  int _curPage = 1;

  @override
  void initState() {
    super.initState();
    //groupItemList();
  }
  void updateUI(){
    setState(() {
      //Refresh page
    });
  }
  final TextEditingController _grnDiscountPercentage = TextEditingController();
  final TextEditingController _discountAmountController = TextEditingController();
  final TextEditingController _gnrDiscountAmountController = TextEditingController();
  final TextEditingController _grnQuantityController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _grnNetAmountController = TextEditingController();


  bool _validate = false;

  @override
  void dispose() {
    _discountAmountController.dispose();
    _grnDiscountPercentage.dispose();
    _quantityController.dispose();
    _gnrDiscountAmountController.dispose();
    _grnQuantityController.dispose();
    super.dispose();
  }


  StepProgressView _getStepProgress() {
    return StepProgressView(
      _stepsText,
      _curPage,
      _stepProgressViewHeight,
      _safeAreaSize.width,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(
        top: 5.0,
        left: 24.0,
        right: 24.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    _safeAreaSize = mediaQD.size;
    //Dependency injection
    var goodsReceivedNoteController = GoodsReceivedNotesController(GoodsReceivedNotesSupplierRepository());
    var supplierController = SupplierController(SuppliersProvider());
    var branchController = BranchesController(BranchesEntitiesRepository());
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
            SingleChildScrollView(
              child: FutureBuilder(
                  future: Future.wait<Object>([
                    goodsReceivedNoteController.fetchGoodsReceivedNote(context),
                    supplierController.fetchSupplierList(context),
                    branchController.fetchBranchList(context)
                  ]),
                  builder: (context,  snapshot){
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
                                    text: "You have a total of 5 goods received notes.",
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
                                      padding: const EdgeInsets.only(top: 5.0, bottom: 8.0,),
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
                                                hintText: "Search goods received notes",
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
                                      width: 10.0,
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
                                      width: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 24.0, ),
                                      child: InkWell(
                                        child: Container(
                                          height: 40.0,
                                          width: 250  ,
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
                                                width:1.0,
                                              ),
                                              Text(
                                                "Add Goods Received notes",
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
                                  text: "You have a total of 5 goods received notes.",
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
                                              hintText: "Search goods received notes",
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
                                    child:  InkWell(
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
                                              return StatefulBuilder(
                                                  builder: (BuildContext context, StateSetter setStatez) {
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
                                                              280,
                                                          padding: EdgeInsets.all(20),
                                                          child: Flexible(
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
                                                                          text: "Add Item",
                                                                          size: 22,
                                                                          color: Colors.blueGrey,
                                                                          weight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Material(
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _discountAmountController.clear();
                                                                          _grnDiscountPercentage.clear();
                                                                          _gnrDiscountAmountController.clear();
                                                                          _grnQuantityController.clear();
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
                                                                Container(
                                                                    height: 50,
                                                                    child: Material(child: _getStepProgress())),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(left: 12.0),
                                                                  child: Material(
                                                                      child: CustomText(
                                                                        text:
                                                                        "Enter details to goods received note.",
                                                                        size: 11.0,
                                                                        color: Colors.blueGrey,
                                                                        weight: FontWeight.w500,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(context).size.height / 3.4,
                                                                  child: PageView(
                                                                    controller: controller,
                                                                    onPageChanged: (i){
                                                                      setStatez(() {
                                                                        _curPage = i+1;
                                                                      });
                                                                    },
                                                                    children: [
                                                                      Column(
                                                                        children: [
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
                                                                                            "Select Supplier",
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
                                                                                                        child: Text("Supplier", style: TextStyle(fontSize:
                                                                                                        12),),
                                                                                                      ),
                                                                                                      value: supplierId,
                                                                                                      items: snapshot.data[1].map<DropdownMenuItem<String>>((item){
                                                                                                        return new DropdownMenuItem<String>(child: Padding(
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: Text(
                                                                                                            item.name,
                                                                                                            style: TextStyle(fontSize:
                                                                                                            12,),
                                                                                                          ),
                                                                                                        ),
                                                                                                            value: item.id.toString()
                                                                                                        );
                                                                                                      }).toList(),
                                                                                                      onChanged: (String groupValue){
                                                                                                        setState(() {
                                                                                                          supplierId = groupValue;

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
                                                                                            "Select Branch",
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
                                                                                                        child: Text("Branch", style: TextStyle(fontSize:
                                                                                                        12),),
                                                                                                      ),
                                                                                                      value: branchId,
                                                                                                      items: snapshot.data[2].map<DropdownMenuItem<String>>((item){
                                                                                                        return new DropdownMenuItem<String>(child: Padding(
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: Text(
                                                                                                            item.name,
                                                                                                            style: TextStyle(fontSize:
                                                                                                            12,),
                                                                                                          ),
                                                                                                        ),
                                                                                                            value: item.id.toString()
                                                                                                        );
                                                                                                      }).toList(),
                                                                                                      onChanged: (String groupValue){
                                                                                                        setState(() {
                                                                                                          branchId = groupValue;

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
                                                                                            "Quantity",
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
                                                                                          child:Flexible(
                                                                                            child: TextField(
                                                                                              controller: _quantityController,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'quantity Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Quantity",
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
                                                                                            "Discount Amount",
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
                                                                                          child:Flexible(
                                                                                            child: TextField(
                                                                                              controller: _discountAmountController,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'discount Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Discount",
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

                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        children: [
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
                                                                                            "Item Discount Percentage",
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
                                                                                          child:Flexible(
                                                                                            child: TextField(
                                                                                              controller: _grnDiscountPercentage,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'percentage Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Percentage",
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
                                                                                            "Item Discount Amount",
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
                                                                                              controller: _gnrDiscountAmountController,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'discount Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Discount",
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
                                                                                            "Item Quantity",
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
                                                                                          child:Flexible(
                                                                                            child: TextField(
                                                                                              controller: _grnQuantityController,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'quantity Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Quantity",
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
                                                                                            "Item Net Amount",
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
                                                                                          child:Flexible(
                                                                                            child: TextField(
                                                                                              controller: _grnNetAmountController,
                                                                                              decoration:
                                                                                              InputDecoration(
                                                                                                  errorText: _validate
                                                                                                      ? 'discount Can\'t Be Empty'
                                                                                                      : null,
                                                                                                  hintText:
                                                                                                  "Discount",
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

                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   height: 15.0,
                                                                // ),
                                                                _curPage ==1 ?
                                                                Flexible(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        right: 25.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.end,
                                                                      children: [
                                                                        Material(
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              _discountAmountController.clear();
                                                                              _grnDiscountPercentage.clear();
                                                                              _quantityController.clear();
                                                                              _gnrDiscountAmountController.clear();
                                                                              _grnQuantityController.clear();
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
                                                                              if (controller.hasClients) {
                                                                                controller.animateToPage(
                                                                                  1,
                                                                                  duration: const Duration(milliseconds: 400),
                                                                                  curve: Curves.easeInOut,
                                                                                );
                                                                              }
                                                                              setStatez(() {

                                                                                // subgroupsController.postSubgroup(_nameController.text, groupId, context);
                                                                                // Navigator.of(context, rootNavigator: true).pop();

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
                                                                                    Icons.arrow_forward_ios,
                                                                                    color: Colors
                                                                                        .white,
                                                                                    size: 15,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 8.0,
                                                                                  ),
                                                                                  Text(
                                                                                    "Next Step",
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
                                                                ) :
                                                                Flexible(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        right: 25.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.end,
                                                                      children: [
                                                                        Material(
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              if (controller.hasClients) {
                                                                                controller.animateToPage(
                                                                                  0,
                                                                                  duration: const Duration(milliseconds: 400),
                                                                                  curve: Curves.easeInOut,
                                                                                );
                                                                              }
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
                                                                                  Icon(Icons.arrow_back_ios,
                                                                                    color: secondaryColor,
                                                                                    size: 15,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 8.0,
                                                                                  ),
                                                                                  Text(
                                                                                    "Back",
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
                                                                              // if (
                                                                              //
                                                                              // ) {
                                                                              //
                                                                                setState(() {
                                                                                  _discountAmountController.clear();
                                                                                  _grnDiscountPercentage.clear();
                                                                                  _quantityController.clear();
                                                                                  _gnrDiscountAmountController.clear();
                                                                                  _grnQuantityController.clear();
                                                                                  Navigator
                                                                                      .of(
                                                                                      context,
                                                                                      rootNavigator: true)
                                                                                      .pop();
                                                                                });
                                                                              // }else{
                                                                              //   null;
                                                                              // }
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
                                                                                    size: 15,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 8.0,
                                                                                  ),
                                                                                  Text(
                                                                                    "Add Note",
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
                                                      ),
                                                    );
                                                  }
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
                                              "Add Item",
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
                                rowsPerPage: 5,
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
                                    "Email",
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
                                source: GoodsReceivedNotesDataSource(
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
          ],)
    );
  }
}