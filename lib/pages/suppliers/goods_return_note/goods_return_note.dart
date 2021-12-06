import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/branches_controller.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/supliers_controller.dart';
import 'package:serow/controllers/supplier_invoices_controller.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/models/inventory/branch_stock.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/entities_repository/branches_entities_repository.dart';
import 'package:serow/repository/suppliers_repository/supplier_invoices_suppliers_repository.dart';
import 'package:serow/repository/suppliers_repository/suppliers_provider.dart';
import 'package:serow/services/services.dart';
import 'package:serow/services/suppier_invoices_data_source.dart';
import 'package:serow/widgets/custom_text.dart';

class TablePurchaseOrder {
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
  String unitPrice;
  String netAmount;
  String sumNetAmount;
  String sumSubTotal;
  String sumDiscountTotal;
  String sumVatTotal;
  String sumTotal;

  TablePurchaseOrder(
      {this.quantity,
        this.bonus,
        this.item,
        this.totalQty,
        this.disc,
        this.discPer,
        this.unitPrice,
        this.vatAmount,
        this.vatPer,
        this.totalAmount,
        this.totalCost,
        this.netAmount,
        this.sumNetAmount,
        this.sumSubTotal,
        this.sumDiscountTotal,
        this.sumVatTotal,
        this.sumTotal});

  static List<TablePurchaseOrder> getTablePurchaseOrder() {
    return tablesPurchaseOrder;
  }

  static addUsers(
      quantity,
      bonus,
      item,
      totalQty,
      totalCost,
      totalAmount,
      disc,
      discPer,
      vatAmount,
      vatPer,
      unitPrice,
      netAmount,
      sumNetAmount,
      sumSubTotal,
      sumDiscountTotal,
      sumVatTotal,
      sumTotal) {
    var tablePurchaseOrder = new TablePurchaseOrder();
    tablePurchaseOrder.quantity = quantity;
    tablePurchaseOrder.bonus = bonus;
    tablePurchaseOrder.item = item;
    tablePurchaseOrder.totalQty = totalQty;
    tablePurchaseOrder.totalCost = totalCost;
    tablePurchaseOrder.totalAmount = totalAmount;
    tablePurchaseOrder.disc = disc;
    tablePurchaseOrder.discPer = discPer;
    tablePurchaseOrder.vatAmount = vatAmount;
    tablePurchaseOrder.vatPer = vatPer;
    tablePurchaseOrder.unitPrice = unitPrice;
    tablePurchaseOrder.netAmount = netAmount;
    tablePurchaseOrder.sumNetAmount = sumNetAmount;
    tablePurchaseOrder.sumSubTotal = sumSubTotal;
    tablePurchaseOrder.sumDiscountTotal = sumDiscountTotal;
    tablePurchaseOrder.sumVatTotal = sumVatTotal;
    tablePurchaseOrder.sumTotal = sumTotal;
    tablesPurchaseOrder.add(tablePurchaseOrder);
  }
}

List<TablePurchaseOrder> tablesPurchaseOrder = [];

class GoodsReturnNotePage extends StatefulWidget {
  const GoodsReturnNotePage({Key key}) : super(key: key);

  @override
  State<GoodsReturnNotePage> createState() => _GoodsReturnNotePageState();
}

class _GoodsReturnNotePageState extends State<GoodsReturnNotePage> {
  List<TablePurchaseOrder> tablesPurchaseOrder;
  List<TablePurchaseOrder> selectedPurchaseOrders;
  bool sort;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController controller = new TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  TextEditingController _discAmountController;
  final TextEditingController _discPercentageController =
  TextEditingController();
  final TextEditingController _netAmountController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _bonusController = TextEditingController();
  TextEditingController _vatAmountController;
  final TextEditingController _vatPercentageController =
  TextEditingController();
  TextEditingController _totalAmountController;
  TextEditingController _totalQuantityController;
  bool _isEditingText = false;
  String initialText = "0.0";

  bool _isQtyEditingText = false;
  String initialQtyText = "0.0";

  bool _isNetEditingText = false;
  String initialNetText = "0.0";

  bool _isVATAmountEditingText = false;
  String initialVATAmountText = "0.0";

  String totalValue;

  bool balanceValue = false;
  bool branchValue = false;
  bool itemValue = false;

  bool balanceQuotationValue = false;
  bool branchQuotationValue = false;
  bool itemQuotationValue = false;

  String itemId;
  String supplierId;
  String branchId;

  String itemQuotationId;
  String customerQuotationId;
  String branchQuotationId;

  TypeAheadField searchTextField;
  TypeAheadField itemTextField;
  TypeAheadField branchTextField;

  double qty = 0;
  double bns = 0;
  double vat = 0;
  double netPrice = 0;
  double itemPrice = 0;
  double discAmount = 0;
  double unitPrice = 0;
  double discPerc = 0;
  double vatPerc = 0;

  @override
  void initState() {
    sort = false;
    selectedPurchaseOrders = [];

    tablesPurchaseOrder = TablePurchaseOrder.getTablePurchaseOrder();

    _quantityController.addListener(() {
      setState(() {
        qty = double.parse(_quantityController.text);
      });
    });

    _discPercentageController.addListener(() {
      setState(() {
        discPerc = double.parse(_discPercentageController.text);
      });
    });

    _unitPriceController.addListener(() {
      setState(() {
        unitPrice = double.parse(_unitPriceController.text);
      });
    });

    _bonusController.addListener(() {
      setState(() {
        bns = double.parse(_bonusController.text);
      });
    });

    _vatPercentageController.addListener(() {
      setState(() {
        vatPerc = double.parse(_vatPercentageController.text);
      });
    });

    _netAmountController.addListener(() {
      setState(() {
        netPrice = double.parse(_netAmountController.text);
      });
    });

    _totalAmountController = TextEditingController(text: initialText);
    _totalQuantityController = TextEditingController(text: initialQtyText);
    _discAmountController = TextEditingController(
        text: "${discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2)}");
    _vatAmountController = TextEditingController(
        text: "${vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2)}");

    super.initState();
    //groupItemList();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        tablesPurchaseOrder.sort((a, b) => a.item.compareTo(b.item));
      } else {
        tablesPurchaseOrder.sort((a, b) => b.item.compareTo(a.item));
      }
    }
  }

  onSelectedRow(bool selected, TablePurchaseOrder sale) async {
    setState(() {
      if (selected) {
        selectedPurchaseOrders.add(sale);
      } else {
        selectedPurchaseOrders.remove(sale);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedPurchaseOrders.isNotEmpty) {
        List<TablePurchaseOrder> temp = [];
        temp.addAll(selectedPurchaseOrders);
        for (TablePurchaseOrder sale in temp) {
          tablesPurchaseOrder.remove(sale);
          selectedPurchaseOrders.remove(sale);
        }
      }
    });
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onSubmitted: (newValue) {
                setState(() {
                  initialText = newValue;
                  _discAmountController.text = newValue;
                  _isEditingText = false;
                });
              },
              autofocus: true,
              controller: _discAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                //  labelText: "Email Address",
                  hintText: "  0.0",
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: primaryColor, width: 0.4),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: 0.4),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          "${discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editNetTextField() {
    if (_isNetEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onSubmitted: (newValue) {
                setState(() {
                  initialNetText = newValue;
                  _isNetEditingText = false;
                });
              },
              autofocus: true,
              controller: _netAmountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                //  labelText: "Email Address",
                  hintText: "  0.0",
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: primaryColor, width: 0.4),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: 0.4),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isNetEditingText = true;
          });
        },
        child: Text(
          "${itemPrice.toPrecision(2) - discAmount.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editVATAmountTextField() {
    if (_isVATAmountEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onSubmitted: (newValue) {
                setState(() {
                  initialVATAmountText = newValue;
                  _isVATAmountEditingText = false;
                });
              },
              autofocus: true,
              controller: _vatAmountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                //  labelText: "Email Address",
                  hintText: "  0.0",
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: primaryColor, width: 0.4),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.grey, width: 0.4),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isVATAmountEditingText = true;
          });
        },
        child: Text(
          "${vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  void updateUI() {
    setState(() {
      //Refresh page
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    controller.dispose();
    _itemController.dispose();
    _quantityController.dispose();
    _discAmountController.dispose();
    _branchController.dispose();
    _discPercentageController.dispose();
    _netAmountController.dispose();
    _unitPriceController.dispose();
    _bonusController.dispose();
    _totalQuantityController.dispose();
    _vatAmountController.dispose();
    _vatPercentageController.dispose();
    _totalAmountController.dispose();
    _quantityController.removeListener(() {});
    _unitPriceController.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemPrice = unitPrice.toPrecision(2) * qty;
    discAmount = discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2);
    vat = vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2);
    netPrice = itemPrice.toPrecision(2) - discAmount.toPrecision(2);

    branchTextField = TypeAheadField<Branches>(
      suggestionsCallback: BranchApi.getBranchSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._branchController,
        decoration: InputDecoration(
            hintText: "Search branch",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final branch = suggestion;
        return ListTile(
          title: Text(branch.name),
        );
      },
      onSuggestionSelected: (Branches suggestion) {
        this._branchController.text = suggestion.name;
        branchId = suggestion.id;
      },
      noItemsFoundBuilder: (context) => Center(child: Text("No branch found!")),
    );
    itemTextField = TypeAheadField<BranchStock>(
      suggestionsCallback: ItemApi.getItemSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._itemController,
        decoration: InputDecoration(
            hintText: "Search item",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final item = suggestion;
        return ListTile(
          title: Text(item.item.name),
        );
      },
      onSuggestionSelected: (BranchStock suggestion) {
        this._itemController.text = suggestion.item.name;
        itemId = suggestion.item.id;
        setState(() {
          itemValue = true;
        });
      },
      noItemsFoundBuilder: (context) => Center(child: Text("No item found!")),
    );
    searchTextField = TypeAheadField<Suppliers>(
      suggestionsCallback: SupplierApi.getCustomersSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._nameController,
        decoration: InputDecoration(
            hintText: "Search supplier",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final supplier = suggestion;
        return ListTile(
          title: Text(supplier.name),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._nameController.text = suggestion.name;
        supplierId = suggestion.id;
        setState(() {
          balanceValue = true;
        });
      },
      noItemsFoundBuilder: (context) =>
          Center(child: Text("No supplier found!")),
    );

    //Dependency injection
    var supplierInvoicesController =
    SupplierInvoicesController(SupplierInvoicesSupplierRepository());
    var supplierController = SupplierController(SuppliersProvider());
    var branchController = BranchesController(BranchesEntitiesRepository());
    return Container(
        color: Colors.blueGrey.shade100.withOpacity(0.1),
        child: SingleChildScrollView(
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
              Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
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
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: Row(
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
                                                    Flexible(
                                                      child: Material(
                                                        child: Container(
                                                          width: 240,
                                                          height: 40,
                                                          child: searchTextField,
                                                        ),
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
                                                          "Ksh ${SupplierApi.customersList[0].creditLimit}",
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
                                                            "Ksh ${SupplierApi.customersList[0].balance}",
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
                                                            ItemApi
                                                                .itemList[
                                                            0]
                                                                .branch ==
                                                                BranchApi
                                                                    .branchList[
                                                                0]
                                                                    .id
                                                            ? Text(
                                                          "${ItemApi.itemList[0].item.balance.toString()}",
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
                                                          "Ksh ${ItemApi.itemList[0].item.minimumPrice}",
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
                                                            "Ksh ${ItemApi.itemList[0].item.maximumPrice}",
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
                                                          "Invoice item",
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
                                                          "${ItemApi.itemList[0].item.name}",
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
                                                              .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
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
                                                              .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
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
                                                              .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
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
                                                      child: Text(
                                                        "${qty.floor() + bns.floor()}",
                                                        style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
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
                                                              .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
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
                                                  _editTitleTextField(),
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
                                                  _editVATAmountTextField(),
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
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                            decimal: true),
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                              r'^\d*\.?\d{0,2}')),
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
                                                  _editNetTextField(),
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
                                                      child: Text(
                                                        "${vat - discAmount + netPrice}",
                                                        style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
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
                                        Column(
                                          children: [
                                            Material(
                                              child: InkWell(
                                                onTap: () {
                                                  var tableInvoice =
                                                  new TablePurchaseOrder();

                                                  tableInvoice.item =
                                                      _itemController.text;
                                                  tableInvoice.bonus =
                                                      _bonusController.text;
                                                  tableInvoice.totalQty =
                                                  "${qty + bns}";
                                                  tableInvoice.quantity =
                                                      _quantityController.text;
                                                  tableInvoice.netAmount =
                                                      _netAmountController.text;
                                                  tableInvoice.unitPrice =
                                                      _unitPriceController.text;
                                                  tableInvoice.vatAmount =
                                                  "${vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2)}";
                                                  tableInvoice.vatPer =
                                                      _vatPercentageController
                                                          .text;
                                                  tableInvoice.disc =
                                                  "${discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2)}";
                                                  tableInvoice.discPer =
                                                      _discPercentageController
                                                          .text;
                                                  tableInvoice.netAmount =
                                                  "${itemPrice - discAmount}";
                                                  tableInvoice.totalAmount =
                                                  "${vat - discAmount + netPrice}";
                                                  tableInvoice.sumSubTotal =
                                                  "${vat.toPrecision(2) - discAmount.toPrecision(2) + netPrice.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2)}";
                                                  tableInvoice.sumNetAmount =
                                                  "${netPrice.toPrecision(2)}";
                                                  tableInvoice.sumDiscountTotal =
                                                  "${discAmount.toPrecision(2)}";
                                                  tableInvoice.sumVatTotal =
                                                  "${vat.toPrecision(2)}";
                                                  tableInvoice.sumTotal =
                                                  "${vat.toPrecision(2) - discAmount.toPrecision(2) + netPrice.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2) + vat.toPrecision(2) - discAmount.toPrecision(2)}";
                                                  tablesPurchaseOrder.add(tableInvoice);
                                                  setState(() {});
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
                                    )),
                              ),
                              //ToDo: Set state  to show the below widget
                              // rowsItem.length >0 ?
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        selectedPurchaseOrders.isEmpty != true
                                            ? InkWell(
                                          onTap: selectedPurchaseOrders.isEmpty
                                              ? null
                                              : () {
                                            deleteSelected();
                                          },
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5.0),
                                              color: bgColor
                                                  .withOpacity(0.2),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Icon(
                                                        Icons.delete,
                                                        color:
                                                        Colors.red)),
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                            : Container(),
                                        DataTable(
                                          sortAscending: sort,
                                          sortColumnIndex: 0,
                                          columns: [
                                            DataColumn(
                                                label: Text(
                                                  "Item",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                onSort:
                                                    (columnIndex, ascending) {
                                                  setState(() {
                                                    sort = !sort;
                                                  });
                                                  onSortColumn(
                                                      columnIndex, ascending);
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
                                                  "Total Qty",
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
                                          rows: tablesPurchaseOrder
                                              .map((e) => DataRow(
                                              selected: selectedPurchaseOrders
                                                  .contains(e),
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
                                                      FontWeight
                                                          .bold),
                                                )),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.quantity,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.quantity =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.bonus,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.bonus = val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.totalQty,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.totalQty =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.disc,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.disc = val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.discPer,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.discPer =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.unitPrice,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.unitPrice =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.netAmount,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.netAmount =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.vatAmount,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.vatAmount =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(
                                                    TextFormField(
                                                      initialValue:
                                                      e.vatPer,
                                                      style: TextStyle(
                                                          color:
                                                          bgColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                          decimal:
                                                          true),
                                                      onFieldSubmitted:
                                                          (val) {
                                                        setState(() {
                                                          e.vatPer =
                                                              val;
                                                        });
                                                      },
                                                    ),
                                                    showEditIcon: true),
                                                DataCell(Text(
                                                  e.totalAmount,
                                                  style: TextStyle(
                                                      color:
                                                      primaryColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                )),
                                              ]))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 17.0, left: 8.0, right: 8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Subtotal",
                                              style: TextStyle(
                                                color: bgColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "Ksh${tablesPurchaseOrder.map((e) => double.parse(e.sumSubTotal)).fold(0, (previousValue, current) => previousValue + current)}",
                                              style: TextStyle(
                                                color: bgColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ]),
                                    SizedBox(height: 15.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Divider(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Discounts",
                                              style: TextStyle(
                                                color: bgColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "- Ksh${tablesPurchaseOrder.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}",
                                              style: TextStyle(
                                                color: bgColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ]),
                                    SizedBox(height: 15.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Divider(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Others",
                                                  style: TextStyle(
                                                    color: bgColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 28.0),
                                                child: Text("~",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    )),
                                              ),
                                            ]),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("VAT",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    )),
                                                Text("-----------------",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    )),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 28.0),
                                                  child: Text(
                                                      "Ksh ${tablesPurchaseOrder.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}",
                                                      style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      )),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Divider(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("TOTAL",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "Ksh${tablesPurchaseOrder.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}",
                                              style: TextStyle(
                                                color: bgColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ]),
                                    SizedBox(height: 15.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Divider(),
                                    ),
                                    SizedBox(height: 10),
                                    // InkWell(
                                    //   onTap: () async {
                                    //     supplierInvoicesController.postSupplierInvoice(
                                    //         supplierId,
                                    //         branchId,
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         "2021-11-25",
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         itemId,
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.quantity)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.unitPrice)).fold(0, (previousValue, element) => previousValue + element)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.bonus)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.totalQty)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.discPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.disc)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.netAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.vatPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.vatAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         double.parse(
                                    //             "${tablesPurchaseOrder.map((e) => double.parse(e.totalAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                    //         context);
                                    //   },
                                    //   child: Container(
                                    //     height: 40.0,
                                    //     width:
                                    //     MediaQuery.of(context).size.width,
                                    //     decoration: BoxDecoration(
                                    //       color: primaryColor,
                                    //       borderRadius:
                                    //       BorderRadius.circular(5.0),
                                    //     ),
                                    //     child: Center(
                                    //         child: Text("Complete Sale",
                                    //             style: TextStyle(
                                    //                 color: Colors.white))),
                                    //   ),
                                    // ),
                                    SizedBox(height: 15),
                                    Center(
                                        child: Text(
                                            "A receipt will be generated and other details saved",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 10)))
                                  ]),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SupplierApi {
  static List<Suppliers> customersList = <Suppliers>[];

  static Future<List<Suppliers>> getCustomersSuggestions(
      String query, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final response = await http.get(
      Uri.parse('${AppUrl.suppliers}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    if (response.statusCode == 200) {
      final Map customers = json.decode(response.body);
      var categoryJson = customers['results'] as List;
      print("Json suppliers: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        customersList.add(new Suppliers.fromJson(categoryJson[i]));
        print("${SupplierApi.customersList[0].creditLimit}");
      }
      return categoryJson
          .map((json) => Suppliers.fromJson(json))
          .where((supplier) {
        final nameLower = supplier.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

class BranchApi {
  static List<Branches> branchList = <Branches>[];

  static Future<List<Branches>> getBranchSuggestions(
      String query, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final response = await http.get(
      Uri.parse('${AppUrl.branches}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    if (response.statusCode == 200) {
      final Map customers = json.decode(response.body);
      var categoryJson = customers['results'] as List;
      print("Json branches: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        branchList.add(new Branches.fromJson(categoryJson[i]));
      }
      return categoryJson
          .map((json) => Branches.fromJson(json))
          .where((customer) {
        final nameLower = customer.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

class ItemApi {
  static List<BranchStock> itemList = <BranchStock>[];

  static Future<List<BranchStock>> getItemSuggestions(
      String query, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final response = await http.get(
      Uri.parse('${AppUrl.branch_stock}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    if (response.statusCode == 200) {
      final Map customers = json.decode(response.body);
      var categoryJson = customers['results'] as List;
      print("Json item: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        itemList.add(new BranchStock.fromJson(categoryJson[i]));
      }
      return categoryJson
          .map((json) => BranchStock.fromJson(json))
          .where((item) {
        final nameLower = item.item.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
