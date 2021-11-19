import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/customers/customers.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/models/inventory/branch_stock.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/services/services.dart';
import 'package:serow/widgets/custom_text.dart';

class TableSale {
  String quantity;
  String bonus;
  String item;
  String totalQty;
  String disc;
  String discPer;
  String totalCost;
  String totalAmount;
  String vatAmount;
  String vatPer;
  String unitCost;
  String unitPrice;
  String netAmount;

  TableSale(
      {this.quantity,
      this.bonus,
      this.item,
      this.totalQty,
      this.disc,
      this.discPer,
      this.unitCost,
      this.unitPrice,
      this.vatAmount,
      this.vatPer,
      this.totalAmount,
      this.totalCost,
      this.netAmount});

  static List<TableSale> getTableSale() {
    return tablesSale;
  }

  static addUsers(quantity, bonus, item, totalQty, totalCost, totalAmount, disc,
      discPer, vatAmount, vatPer, unitCost, unitPrice, netAmount) {
    var tableSale = new TableSale();
    tableSale.quantity = quantity;
    tableSale.bonus = bonus;
    tableSale.item = item;
    tableSale.totalQty = totalQty;
    tableSale.totalCost = totalCost;
    tableSale.totalAmount = totalAmount;
    tableSale.disc = disc;
    tableSale.discPer = discPer;
    tableSale.vatAmount = vatAmount;
    tableSale.vatPer = vatPer;
    tableSale.unitCost = unitCost;
    tableSale.unitPrice = unitPrice;
    tableSale.netAmount = netAmount;
    tablesSale.add(tableSale);
  }
}

List<TableSale> tablesSale = [];

class POSPage extends StatefulWidget {
  const POSPage({Key key}) : super(key: key);

  @override
  _POSPageState createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<TableSale> tablesSale;
  List<TableSale> selectedSales;
  bool sort;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController controller = new TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _discAmountController = TextEditingController();
  final TextEditingController _discPercentageController =
      TextEditingController();
  final TextEditingController _netAmountController = TextEditingController();
  final TextEditingController _unitCostController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _bonusController = TextEditingController();
  final TextEditingController _totalQtyController = TextEditingController();
  final TextEditingController _vatAmountController = TextEditingController();
  final TextEditingController _vatPercentageController =
      TextEditingController();
  TextEditingController _totalAmountController;
  TextEditingController _totalQuantityController;

  bool _isEditingText = false;
  String initialText = "0.0";

  bool _isQtyEditingText = false;
  String initialQtyText = "0.0";

  GlobalKey<AutoCompleteTextFieldState<Customers>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<BranchStock>> itemKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Branches>> branchKey = new GlobalKey();

  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  bool balanceValue = false;
  bool branchValue = false;
  bool itemValue = false;
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField itemTextField;
  AutoCompleteTextField branchTextField;

  List rowsItem = [];

  Future makeSales(BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context).auth;
  }

  @override
  void initState() {
    sort = false;
    selectedSales = [];
    tablesSale = TableSale.getTableSale();
    _tabController = new TabController(length: 3, initialIndex: 1, vsync: this);
    _loadData();
    _totalAmountController = TextEditingController(text: initialText);
    _totalQuantityController = TextEditingController(text: initialQtyText);
    super.initState();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        tablesSale.sort((a, b) => a.item.compareTo(b.item));
      } else {
        tablesSale.sort((a, b) => b.item.compareTo(a.item));
      }
    }
  }

  onSelectedRow(bool selected, TableSale sale) async {
    setState(() {
      if (selected) {
        selectedSales.add(sale);
      } else {
        selectedSales.remove(sale);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedSales.isNotEmpty) {
        List<TableSale> temp = [];
        temp.addAll(selectedSales);
        for (TableSale sale in temp) {
          tablesSale.remove(sale);
          selectedSales.remove(sale);
        }
      }
    });
  }

  void _loadData() async {
    await CustomersViewModel.loadCustomers(context);
    await ItemsViewModel.loadItems(context);
    await BranchesViewModel.loadBranches(context);
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _totalAmountController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editQuantityTextField() {
    if (_isQtyEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialQtyText = newValue;
              _isQtyEditingText = false;
            });
          },
          autofocus: true,
          controller: _totalQtyController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isQtyEditingText = true;
          });
        },
        child: Text(
          initialQtyText,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    controller.dispose();
    _quantityController.dispose();
    _discAmountController.dispose();
    _discPercentageController.dispose();
    _netAmountController.dispose();
    _unitCostController.dispose();
    _unitPriceController.dispose();
    _bonusController.dispose();
    _totalQtyController.dispose();
    _vatAmountController.dispose();
    _vatPercentageController.dispose();
    _totalAmountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    branchTextField = AutoCompleteTextField<Branches>(
      suggestions: BranchesViewModel.branches,
      itemBuilder: (context, item) {
        return Text(
          item.name,
          style: TextStyle(fontSize: 14.0),
        );
      },
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.name.compareTo(b.name);
      },
      clearOnSubmit: false,
      itemSubmitted: (item) {
        setState(() {
          branchTextField.textField.controller.text = item.name;
          //rowsItem.add(item.name.toString());
          branchValue = true;
        });
      },
      key: branchKey,
      onFocusChanged: (hasFocus) {},
      decoration: InputDecoration(
          hintText: "Search branch",
          hintStyle: TextStyle(fontSize: 12),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 0.4),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.4),
              borderRadius: BorderRadius.circular(5))),
    );
    itemTextField = AutoCompleteTextField<BranchStock>(
      suggestions: ItemsViewModel.items,
      itemBuilder: (context, item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.item.name,
            style: TextStyle(fontSize: 14.0),
          ),
        );
      },
      itemFilter: (item, query) {
        return item.item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.item.name.compareTo(b.item.name);
      },
      clearOnSubmit: false,
      itemSubmitted: (item) {
        setState(() {
          itemTextField.textField.controller.text = item.item.name;
          // rowsItem.add(item.name.toString());
          itemValue = true;
        });
      },
      key: itemKey,
      onFocusChanged: (hasFocus) {},
      decoration: InputDecoration(
          hintText: "Search item",
          hintStyle: TextStyle(fontSize: 12),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 0.4),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.4),
              borderRadius: BorderRadius.circular(5))),
    );
    searchTextField = AutoCompleteTextField<Customers>(
      suggestions: CustomersViewModel.customers,
      itemBuilder: (context, item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(fontSize: 14.0),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Text(
              item.phone,
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        );
      },
      itemFilter: (item, query) {
        return item.name.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.name.compareTo(b.name);
      },
      clearOnSubmit: false,
      itemSubmitted: (item) {
        setState(() {
          searchTextField.textField.controller.text = item.name;
          // rowsItem.add(item.name.toString());
          balanceValue = true;
        });
      },
      key: key,
      onFocusChanged: (hasFocus) {},
      decoration: InputDecoration(
          hintText: "Search customer",
          hintStyle: TextStyle(fontSize: 12),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 0.4),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.4),
              borderRadius: BorderRadius.circular(5))),
    );

    return Column(
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
          padding: const EdgeInsets.only(right: 15.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade100,
            child: DefaultTabController(
              length: 3,
              child: Container(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: secondaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    color: primaryColor,
                  ),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("SALES"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("QUOTATIONS"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("SALES RETURN"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Customer",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 240,
                                                    height: 40,
                                                    child: searchTextField,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Credit limit",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                    child: balanceValue == true
                                                        ? Text(
                                                            "Ksh ${CustomersViewModel.customers[0].creditLimit}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            "Ksh 0.0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Column(
                                                children: [
                                                  Material(
                                                      child: Text(
                                                    "Balance",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Material(
                                                      child: balanceValue ==
                                                              true
                                                          ? Text(
                                                              "Ksh ${CustomersViewModel.customers[0].balance}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "Ksh 0.0",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12.0),
                                        child: Divider(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Branch",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 240,
                                                    height: 48,
                                                    child: branchTextField,
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
                                                Material(
                                                    child: Text(
                                                  "Item",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 240,
                                                    height: 48,
                                                    child: itemTextField,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: Text(
                                                    "Stock",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: itemValue ==
                                                                  true &&
                                                              ItemsViewModel
                                                                      .items[0]
                                                                      .branch ==
                                                                  BranchesViewModel
                                                                      .branches[
                                                                          0]
                                                                      .id
                                                          ? Text(
                                                              "${ItemsViewModel.items[0].item.balance.toString()}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "stock",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: Text(
                                                    "Min price",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: itemValue == true
                                                          ? Text(
                                                              "Ksh ${ItemsViewModel.items[0].item.minimumPrice}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "Ksh 0.0",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 12.0,
                                                    ),
                                                    child: Material(
                                                        child: Text(
                                                      "Max price",
                                                      style: TextStyle(
                                                          color: bgColor,
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Material(
                                                        child: itemValue == true
                                                            ? Text(
                                                                "Ksh ${ItemsViewModel.items[0].item.maximumPrice}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                "Ksh 0.0",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12.0),
                                        child: Divider(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: Text(
                                                    "Sales item",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  child: Material(
                                                      child: itemValue == true
                                                          ? Text(
                                                              "${ItemsViewModel.items[0].item.name}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "Item",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Quantity",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _quantityController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Unit cost",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _unitCostController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Unit price",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _unitPriceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Bonus",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _bonusController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Column(
                                                children: [
                                                  Material(
                                                      child: Text(
                                                    "Total Quantity",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Material(
                                                    child:
                                                        _editQuantityTextField(),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Disc percentage",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _discPercentageController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Disc amount",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _discAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "VAT amount",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _vatAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "VAT percentage",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _vatPercentageController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              //  labelText: "Email Address",
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Material(
                                                    child: Text(
                                                  "Net amount",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Material(
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: TextField(
                                                      controller:
                                                          _netAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: "  0.0",
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 12,
                                                              ),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Column(
                                                children: [
                                                  Material(
                                                      child: Text(
                                                    "Total Amount",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Material(
                                                      child:
                                                          _editTitleTextField()),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Material(
                                            child: InkWell(
                                              onTap: () {
                                                var tableSale = new TableSale();
                                                tableSale.item = itemTextField
                                                    .textField.controller.text;
                                                tableSale.bonus =
                                                    _bonusController.text;
                                                tableSale.totalQty =
                                                    _totalQtyController.text;
                                                tableSale.quantity =
                                                    _quantityController.text;
                                                tableSale.netAmount =
                                                    _netAmountController.text;
                                                tableSale.unitPrice =
                                                    _unitPriceController.text;
                                                tableSale.unitCost =
                                                    _unitCostController.text;
                                                tableSale.vatAmount =
                                                    _vatAmountController.text;
                                                tableSale.vatPer =
                                                    _vatPercentageController
                                                        .text;
                                                tableSale.disc =
                                                    _discAmountController.text;
                                                tableSale.discPer =
                                                    _discPercentageController
                                                        .text;
                                                tableSale.netAmount =
                                                    _netAmountController.text;
                                                tableSale.totalAmount =
                                                    _totalAmountController.text;
                                                tablesSale.add(tableSale);
                                                print(tableSale.quantity);
                                                // if (_quantityController.value.text.isNotEmpty &&
                                                //     _discAmountController
                                                //         .value
                                                //         .text
                                                //         .isNotEmpty &&
                                                //     _discPercentageController
                                                //         .value
                                                //         .text
                                                //         .isNotEmpty &&
                                                //     _netAmountController.value
                                                //         .text.isNotEmpty &&
                                                //     _unitCostController.value
                                                //         .text.isNotEmpty &&
                                                //     _unitPriceController.value
                                                //         .text.isNotEmpty &&
                                                //     _bonusController.value
                                                //         .text.isNotEmpty) {
                                                setState(() {
                                                  _quantityController.clear();
                                                  _discAmountController.clear();
                                                  _discPercentageController
                                                      .clear();
                                                  _netAmountController.clear();
                                                  _unitCostController.clear();
                                                  _unitPriceController.clear();
                                                  _bonusController.clear();
                                                  _vatPercentageController
                                                      .clear();
                                                  _vatAmountController.clear();
                                                  _totalQtyController.clear();
                                                  _totalAmountController
                                                      .clear();
                                                  branchTextField
                                                      .textField.controller
                                                      .clear();
                                                  itemTextField
                                                      .textField.controller
                                                      .clear();
                                                  searchTextField
                                                      .textField.controller
                                                      .clear();
                                                });
                                                // }else{
                                                //   null;
                                                // }
                                              },
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: primaryColor,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      Text("Add Item",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              //ToDo: Set state  to show the below widget
                              // rowsItem.length >0 ?
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      sortAscending: sort,
                                      sortColumnIndex: 0,
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                              "Item",
                                              style: TextStyle(
                                                  color: bgColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onSort: (columnIndex, ascending) {
                                              setState(() {
                                                sort = !sort;
                                              });
                                              onSortColumn(columnIndex, ascending);
                                            }),
                                        DataColumn(
                                            label: Text(
                                          "Quantity",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Bonus",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Disc",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Disc %",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "UP",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "UC",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Net",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "VAT",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "VAT %",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Total",
                                          style: TextStyle(
                                              color: bgColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                      rows: tablesSale
                                          .map((e) => DataRow(
                                          selected: selectedSales.contains(e),
                                          onSelectChanged: (b) {
                                            onSelectedRow(b, e);
                                          },
                                          cells: [
                                                DataCell(Text(
                                                  e.item,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.quantity,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.bonus,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.disc,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.discPer,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.unitPrice,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.unitCost,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.netAmount,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.vatAmount,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.vatPer,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(Text(
                                                  e.totalAmount,
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: SingleChildScrollView(
                              //     child: DataTable(
                              //       sortColumnIndex: _currentSortColumn,
                              //       sortAscending: _isSortAsc,
                              //       columns: [
                              //         DataColumn(
                              //             label: Text(
                              //               "Item",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Quantity",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Disc",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Disc %",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Bonus",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Net",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //         DataColumn(
                              //             label: Text(
                              //               "Batch",
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //       ],
                              //       rows: rowsItem.map((e) => DataRow(
                              //           cells:[
                              //             DataCell(Text(
                              //              '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //             DataCell(Text(
                              //               '',
                              //               style: TextStyle(
                              //                   color: bgColor,
                              //                   fontSize: 10,
                              //                   fontWeight: FontWeight.bold),
                              //             )),
                              //
                              //           ]
                              //       )).toList(),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, left: 3.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.6),
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.red,
                          child: Text("SALES RETURN"),
                        )),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, left: 3.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.red,
                          child: Text("SALES RETURN"),
                        )),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, left: 3.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                ),
              ]),
        )
      ],
    );
  }
}

class CustomersViewModel {
  static List<Customers> customers = <Customers>[];

  static Future loadCustomers(BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    try {
      customers = new List<Customers>();
      var jsonString = await http.get(
        Uri.parse('${AppUrl.customers}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer ${user.accessToken.toString()}"
        },
      );
      Map parsedJson = json.decode(jsonString.body);
      var categoryJson = parsedJson['results'] as List;
      print("Json: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        customers.add(new Customers.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}

class ItemsViewModel {
  static List<BranchStock> items = <BranchStock>[];

  static Future loadItems(BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    try {
      items = new List<BranchStock>();
      var jsonString = await http.get(
        Uri.parse('${AppUrl.branch_stock}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer ${user.accessToken.toString()}"
        },
      );
      Map parsedJson = json.decode(jsonString.body);
      var categoryJson = parsedJson['results'] as List;
      print("Json: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        items.add(new BranchStock.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}

class BranchesViewModel {
  static List<Branches> branches = <Branches>[];

  static Future loadBranches(BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    try {
      branches = new List<Branches>();
      var jsonString = await http.get(
        Uri.parse('${AppUrl.branches}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer ${user.accessToken.toString()}"
        },
      );
      Map parsedJson = json.decode(jsonString.body);
      var categoryJson = parsedJson['results'] as List;
      print("Json Branch: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        branches.add(new Branches.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
