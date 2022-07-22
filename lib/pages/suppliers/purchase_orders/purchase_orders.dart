import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/purchase_orders_controller.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/models/inventory/branch_stock.dart';
import 'package:serow/models/suppliers/supplier_invoices.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/pages/suppliers/purchase_orders/purchase_orders_lists.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/suppliers_repository/purchase_orders_suppliers_repository.dart';
import 'package:serow/routes/routes.dart';
import 'package:serow/services/services.dart';
import 'package:serow/widgets/custom_text.dart';
import 'package:sweetalert/sweetalert.dart';

class TablePurchaseOrder {
  Decimal quantity;
  Decimal bonus;
  String item;
  Decimal totalQty;
  Decimal disc;
  Decimal discPer;
  Decimal totalCost;
  Decimal totalAmount;
  Decimal vatAmount;
  Decimal vatPer;
  Decimal unitPrice;
  Decimal netAmount;
  Decimal sumNetAmount;
  Decimal sumSubTotal;
  Decimal sumDiscountTotal;
  Decimal sum;
  Decimal sumVatTotal;
  Decimal sumTotal;
  Map<String, dynamic> supItems;

  TablePurchaseOrder(
      {this.quantity,
      this.bonus,
      this.supItems,
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
      supItems,
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
    tablePurchaseOrder.supItems = supItems;
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

class PurchaseOrdersPage extends StatefulWidget {
  const PurchaseOrdersPage({Key key}) : super(key: key);

  @override
  State<PurchaseOrdersPage> createState() => _PurchaseOrdersPageState();
}

class _PurchaseOrdersPageState extends State<PurchaseOrdersPage> {
  List<TablePurchaseOrder> tablesPurchaseOrder;
  List<TablePurchaseOrder> selectedPurchaseOrders;
  List<Map<String, dynamic>> itemList;
  bool sort;
  bool showList = false;

  // Default Form Loading State
  bool _loginFormLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tradeDiscController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController controller = new TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  TextEditingController _discAmountController;
  TextEditingController _discPercentageController;

  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _bonusController = TextEditingController();
  TextEditingController _vatAmountController;
  final TextEditingController _vatPercentageController =
      TextEditingController();
  TextEditingController _totalAmountController;
  TextEditingController _totalQuantityController;

  DateTime initialDate = DateTime.now();
  DateTime expiryDate = DateTime.now();

  var myFormat = DateFormat('yyyy-MM-d');
  var datTimeFormat = DateFormat('MMM d, yyyy  hh:mm aaa');

  bool _isTradeEditingText = false;
  TextEditingController _tradeEditingController;
  String initialTradeText = "0.0";

  String initialDiscPercentageText = "0.0";
  String initialAmountText = "0.0";

  bool _isDiscEditingText = false;

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
  bool editValue = false;

  bool discountValueController = false;
  bool newDiscountValueController = false;

  bool balanceQuotationValue = false;
  bool branchQuotationValue = false;
  bool itemQuotationValue = false;

  String itemId;
  String supplierId;
  String branchId;

  double supBalance = 0.0;
  double supLimit = 0.0;
  double itemStock = 0.0;
  String branchStockId = '';
  double itemMinPrice = 0.0;

  double itemMaxPrice = 0.0;

  String itemQuotationId;
  String customerQuotationId;
  String branchQuotationId;

  TypeAheadField searchTextField;
  TypeAheadField itemTextField;
  TypeAheadField branchTextField;

  double qty = 0.0;
  double bns = 0.0;
  double vat = 0.0;
  double netAmount = 0.0;
  double totalCost = 0.0;
  double discAmount = 0.0;
  double unitCost = 0.0;
  double discPerc = 0.0;
  double vatPerc = 0.0;

  int pageNo = 1;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  List listPurchaseOrders = List();
  Uri apiUrl = Uri.parse(AppUrl.purchase_orders);

  //Dependency injection
  var purchaseOrdersController =
  PurchaseOrdersController(PurchaseOrdersSupplierRepository());

  @override
  void initState() {
    sort = false;
    // this._fetchData();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _fetchData();
    //   }
    // });
    selectedPurchaseOrders = [];
    itemList = [];
    _totalAmountController = TextEditingController(text: initialAmountText);
    _totalQuantityController = TextEditingController(text: initialQtyText);
    _discAmountController = TextEditingController(text: initialText);
    _discPercentageController =
        TextEditingController(text: initialDiscPercentageText);
    _vatAmountController = TextEditingController(text: "0.0");

    tablesPurchaseOrder = TablePurchaseOrder.getTablePurchaseOrder();

    _quantityController.addListener(() {
      setState(() {
        qty = double.parse(_quantityController.text);
      });
    });

    _unitPriceController.addListener(() {
      setState(() {
        unitCost = double.parse(_unitPriceController.text);
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

    super.initState();
    //groupItemList();
  }

  // void _fetchData() async {
  //   Auth user = Provider
  //       .of<AuthProvider>(context)
  //       .auth;
  //   if (!isLoading) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     try {
  //       var response = await http.get(apiUrl, headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         "Authorization":
  //         "Bearer ${user.accessToken.toString()}"
  //       },);
  //       if (response.statusCode == 200) {
  //         List albumList = List();
  //         var resultBody;
  //         pageNo =
  //         (pageNo > 100) ? 1 : pageNo++; // resetting and incrementing page
  //        // apiUrl = Uri.parse('${AppUrl.purchase_orders}/?page=$pageNo');
  //
  //         resultBody = jsonDecode(response.body);
  //         print(resultBody['results']);
  //         for (int i = 0; i < resultBody['results'].length; i++) {
  //           albumList.add(resultBody[i]);
  //         }
  //         setState(() {
  //           isLoading = false;
  //           listPurchaseOrders.addAll(albumList);
  //         });
  //       }
  //       else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     } catch (_) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

  Widget _buildList() {
    return FutureBuilder(
        future: purchaseOrdersController.fetchPurchaseOrderList(context),
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == snapshot.data.length) {
                return _buildProgressIndicator();
              } else {
                return Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    ),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:18.0),
                          child: Text(snapshot.data[index].code.toString(),
                            style: TextStyle(fontSize: 12.0,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(datTimeFormat.format( snapshot.data[index].createdAt),
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                        ),
                        Text(snapshot.data[index].supplier.name,
                          style: TextStyle(fontSize: 12.0,),
                        ),
                        Text(snapshot.data[index].noOfItems.toString(),
                          style: TextStyle(fontSize: 12.0,),),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(snapshot.data[index].totalAmount.toString(),
                            style: TextStyle(fontSize: 12.0,),),
                        ),
                      ],
                    )
                );
              }
            },
            controller: _scrollController,
          );
        }
    );
    // return listPurchaseOrders.length < 1
    //     ? Center(
    //   child: Container(
    //     child: Text(
    //       'No data',
    //       style: TextStyle(
    //         fontSize: 20.0,
    //       ),
    //     ),
    //   ),
    // )
    //     : ;
  }
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
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
          itemList.remove(sale);
        }
      }
    });
  }

  editSelected() async {
    setState(() {
      if (selectedPurchaseOrders.isNotEmpty) {
        List<TablePurchaseOrder> temp = [];
        temp.addAll(selectedPurchaseOrders);
        for (TablePurchaseOrder sale in temp) {
          _quantityController.text = sale.quantity.toString();
          _itemController.text = sale.item.toString();
          _bonusController.text = sale.bonus.toString();
          _totalQuantityController.text = sale.totalQty.toString();
          _discAmountController.text = sale.disc.toString();
          _discPercentageController.text = sale.discPer.toString();
          _vatAmountController.text = sale.vatAmount.toString();
          _vatPercentageController.text = sale.vatPer.toString();
          editValue = true;
        }
      }
    });
  }

  Widget _editDiscAmountField() {
    if (_isEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onChanged: (disc) {
                setState(() {
                  discAmount = double.parse(disc);
                  initialDiscPercentageText =
                      "${double.parse(disc) / totalCost * 100}";
                });
              },
              onSubmitted: (newValue) {
                setState(() {
                  initialText = newValue;
                  // initialDiscText = "${discAmount / totalCost * 100}";
                  _isEditingText = false;
                  discountValueController = false;
                });
              },
              autofocus: true,
              controller: _discAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
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
            discountValueController = true;
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

  Widget _editDiscPercField() {
    if (_isDiscEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onChanged: (disc) {
                setState(() {
                  discPerc = double.parse(disc);
                  initialText = "${double.parse(disc) / 100 * totalCost}";
                });
              },
              onSubmitted: (newValue) {
                setState(() {
                  initialDiscPercentageText = newValue;
                  // initialDiscText = "${discAmount / totalCost * 100}";
                  _isDiscEditingText = false;
                  newDiscountValueController = false;
                });
              },
              autofocus: true,
              controller: _discPercentageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
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
            newDiscountValueController = true;
            _isDiscEditingText = true;
          });
        },
        child: Text(
          initialDiscPercentageText,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editDiscAmountCounterTextField() {
    return InkWell(
        onTap: () {
          setState(() {});
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editDiscPerCounterField() {
    return InkWell(
        onTap: () {
          setState(() {});
        },
        child: Text(
          initialDiscPercentageText,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editNetTextField() {
    return Text(
      "${totalCost - double.parse(initialText)}",
      style: TextStyle(
        color: primaryColor,
        fontSize: 18.0,
      ),
    );
  }

  Widget _editVATAmountTextField() {
    return Text(
      "${(vatPerc / 100 * netAmount).toPrecision(2)}",
      style: TextStyle(
        color: primaryColor,
        fontSize: 18.0,
      ),
    );
  }

  Widget _editDateReceivedDiscountTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
              "${initialDate.year}-${initialDate.month}-${initialDate.day}"),
        ),
        TextButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text('Select Date')

            //hintText: ('${myFormat.format(initialDate)}'),
            ),
      ],
    );
    //));
  }

  Widget _editTradeDiscountTextField() {
    if (_isTradeEditingText)
      return Center(
        child: Material(
          child: Container(
            width: 48,
            height: 48,
            child: TextField(
              onSubmitted: (newValue) {
                setState(() {
                  initialTradeText = newValue;
                  _isTradeEditingText = false;
                });
              },
              autofocus: true,
              controller: _tradeEditingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                  //  labelText: "Email Address",
                  // hintText: "  0.0",
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
            _isTradeEditingText = true;
          });
        },
        child: Text(
          initialTradeText,
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
    _nameController.dispose();
    controller.dispose();
    _itemController.dispose();
    _quantityController.dispose();
    _discAmountController.dispose();
    _branchController.dispose();
    _discPercentageController.dispose();
    _unitPriceController.dispose();
    _bonusController.dispose();
    _tradeDiscController.dispose();
    _totalQuantityController.dispose();
    _vatAmountController.dispose();
    _vatPercentageController.dispose();
    _totalAmountController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    setState(() {
      initialDate = picked ?? initialDate;
    });
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error ?? "Please enter correct details"),
            ),
            actions: [
              TextButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<void> _successAlertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Container(
              child: Text(error ?? "Invoice successfully saved!"),
            ),
            actions: [
              TextButton(
                child: Text("View Invoice"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  vatTotalCallBack() {
    var total = Decimal.parse("0.0");
    for (var item in TablePurchaseOrder.getTablePurchaseOrder()) {
      total += item.sumVatTotal;
    }
    return total;
  }

  discountTotalCallBack() {
    var total = Decimal.parse("0.0");
    for (var item in TablePurchaseOrder.getTablePurchaseOrder()) {
      total += item.sumDiscountTotal;
    }
    return total;
  }

  subTotalCallBack() {
    var total = Decimal.parse("0.0");
    for (var item in TablePurchaseOrder.getTablePurchaseOrder()) {
      total += item.sumSubTotal;
    }
    return total;
  }

  totalCallBack() {
    var total = Decimal.parse("0.0");
    for (var item in TablePurchaseOrder.getTablePurchaseOrder()) {
      total += item.sumTotal;
    }
    return total;
  }


  @override
  Widget build(BuildContext context) {
    totalCost = unitCost.toPrecision(2) * qty;
    discAmount = discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2);
    vat = vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2);
    netAmount = totalCost.toPrecision(2) - double.parse(initialText);

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
        if (branchId == suggestion.branch) {
          return ListTile(
            title: Text(item.item.name),
          );
        }
        return Container();
      },
      onSuggestionSelected: (BranchStock suggestion) {
        this._itemController.text = suggestion.item.name;
        itemId = suggestion.item.id;
        itemStock = suggestion.balance;
        branchStockId = suggestion.branch;
        itemMinPrice = suggestion.minimumPrice;
        itemMaxPrice = suggestion.maximumPrice;
        print(branchStockId);
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
        supBalance = suggestion.balance;
        supLimit = suggestion.creditLimit;

        setState(() {
          balanceValue = true;
        });
      },
      noItemsFoundBuilder: (context) =>
          Center(child: Text("No supplier found!")),
    );



    return Container(
        color: Colors.blueGrey.shade100.withOpacity(0.1),
        child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  ),
                  showList == true
                  ? Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: InkWell(
                        onTap: () {
                          navigationController.navigateTo(PurchaseOrdersPageRoute);
                          setState(() {
                            showList == false;
                          });
                        },
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ) :
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showList == true;
                          });
                        },
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            showList == false
                ? Container(
            height: MediaQuery.of(context).size.height /1.4,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, right:20.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: primaryColor.withOpacity(0.4),
                          ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text("Code", style: TextStyle(fontSize: 15.0),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 90.0),
                                    child: Text("Date", style: TextStyle(fontSize: 15.0),),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 100.0),
                                    child: Text("Supplier", style: TextStyle(fontSize: 15.0),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("No items", style: TextStyle(fontSize: 15.0),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text("Total", style: TextStyle(fontSize: 15.0),),
                                  ),

                            ]
                            ),
                        ),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 45.0, right:20.0),
                        child: _buildList(),
                      ))
                    ]),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.22,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
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
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Material(
                                                            child: Text(
                                                          "Supplier",
                                                          style: TextStyle(
                                                              color: bgColor,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Material(
                                                          child: Container(
                                                            width: 240,
                                                            height: 40,
                                                            child:
                                                                searchTextField,
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
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Material(
                                                            child:
                                                                balanceValue ==
                                                                        true
                                                                    ? Text(
                                                                        "Ksh $supLimit",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                8,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        "Ksh 0.0",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                8,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Material(
                                                              child:
                                                                  balanceValue ==
                                                                          true
                                                                      ? Text(
                                                                          "Ksh $supBalance",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          "Ksh 0.0",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Column(
                                                        children: [
                                                          Material(
                                                              child: Text(
                                                            "Expected Date",
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Material(
                                                            child:
                                                                _editDateReceivedDiscountTextField(),
                                                          ),
                                                          SizedBox(),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Material(
                                                            child: Text(
                                                          "Branch",
                                                          style: TextStyle(
                                                              color: bgColor,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Material(
                                                          child: Container(
                                                            width: 240,
                                                            height: 48,
                                                            child:
                                                                branchTextField,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Material(
                                                            child: Text(
                                                          "Item",
                                                          style: TextStyle(
                                                              color: bgColor,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Material(
                                                          child: Container(
                                                            width: 240,
                                                            height: 48,
                                                            child:
                                                                itemTextField,
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
                                                          "Trade Disc",
                                                          style: TextStyle(
                                                              color: bgColor,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Material(
                                                          child:
                                                              _editTradeDiscountTextField(),
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                              child: Text(
                                                            "Stock",
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                            child: itemValue ==
                                                                        true &&
                                                                    branchStockId ==
                                                                        branchId
                                                                ? Text(
                                                                    "$itemStock",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Text(
                                                                    "stock",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                              child: Text(
                                                            "Min price",
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                              child:
                                                                  itemValue ==
                                                                          true
                                                                      ? Text(
                                                                          "Ksh $itemMinPrice",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          "Ksh 0.0",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 12.0,
                                                            ),
                                                            child: Material(
                                                                child: Text(
                                                              "Max price",
                                                              style: TextStyle(
                                                                  color:
                                                                      bgColor,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0),
                                                            child: Material(
                                                                child:
                                                                    itemValue ==
                                                                            true
                                                                        ? Text(
                                                                            "Ksh $itemMaxPrice",
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 8,
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        : Text(
                                                                            "Ksh 0.0",
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 8,
                                                                                fontWeight: FontWeight.bold),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                              child: Text(
                                                            "Order item",
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0),
                                                          child: Material(
                                                              child:
                                                                  itemValue ==
                                                                          true
                                                                      ? Text(
                                                                          "${ItemApi.itemList[0].item.name}",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          "Item",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'^\d*\.?\d{0,2}')),
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "  0",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.grey,
                                                                              width: 0.4),
                                                                          borderRadius: BorderRadius.circular(5))),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'^\d*\.?\d{0,2}')),
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "  0.0",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.grey,
                                                                              width: 0.4),
                                                                          borderRadius: BorderRadius.circular(5))),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'^\d*\.?\d{0,2}')),
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "  0",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.grey,
                                                                              width: 0.4),
                                                                          borderRadius: BorderRadius.circular(5))),
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
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Material(
                                                            child: Text(
                                                              "${qty.floor() + bns.floor()}",
                                                              style: TextStyle(
                                                                color:
                                                                    primaryColor,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        discountValueController ==
                                                                true
                                                            ? _editDiscPerCounterField()
                                                            : _editDiscPercField(),
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
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        newDiscountValueController ==
                                                                true
                                                            ? _editDiscAmountCounterTextField()
                                                            : _editDiscAmountField(),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                                      decimal:
                                                                          true),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'^\d*\.?\d{0,2}')),
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                      //  labelText: "Email Address",
                                                                      hintText:
                                                                          "  0.0",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color:
                                                                                  primaryColor,
                                                                              width:
                                                                                  0.4),
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.grey,
                                                                              width: 0.4),
                                                                          borderRadius: BorderRadius.circular(5))),
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
                                                                  FontWeight
                                                                      .bold),
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
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Material(
                                                            child: Text(
                                                              "${vat + netAmount}",
                                                              style: TextStyle(
                                                                color:
                                                                    primaryColor,
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
                                                  editValue == true
                                                      ? Material(
                                                          child: InkWell(
                                                            onTap: () {
                                                              var tableInvoice =
                                                                  new TablePurchaseOrder();

                                                              tableInvoice
                                                                      .item =
                                                                  _itemController
                                                                      .text;
                                                              tableInvoice
                                                                      .bonus =
                                                                  Decimal.parse(
                                                                      _bonusController
                                                                          .text);
                                                              tableInvoice
                                                                      .totalQty =
                                                                  Decimal.parse(
                                                                      "${qty + bns}");
                                                              tableInvoice
                                                                      .quantity =
                                                                  Decimal.parse(
                                                                      _quantityController
                                                                          .text);
                                                              tableInvoice
                                                                      .netAmount =
                                                                  Decimal.parse(
                                                                      "$netAmount");
                                                              tableInvoice
                                                                      .unitPrice =
                                                                  Decimal.parse(
                                                                      _unitPriceController
                                                                          .text);
                                                              tableInvoice
                                                                      .vatAmount =
                                                                  Decimal.parse(
                                                                      "${(vatPerc / 100 * netAmount).toPrecision(2)}");
                                                              tableInvoice
                                                                      .vatPer =
                                                                  Decimal.parse(
                                                                      _vatPercentageController
                                                                          .text);
                                                              tableInvoice
                                                                  .supItems = {
                                                                "item": itemId,
                                                                "quantity":
                                                                    _quantityController
                                                                        .text,
                                                                "unit_cost":
                                                                    unitCost,
                                                                'total_cost':
                                                                    totalCost -
                                                                        double.parse(
                                                                            initialText),
                                                                "bonus":
                                                                    _bonusController
                                                                        .text,
                                                                "total_quantity":
                                                                    qty + bns,
                                                                "discount_percentage":
                                                                    Decimal.parse(
                                                                        initialDiscPercentageText),
                                                                "discount_amount":
                                                                    Decimal.parse(
                                                                        initialText),
                                                                "net_amount":
                                                                    Decimal.parse(
                                                                        "${totalCost - double.parse(initialText).toPrecision(2)}"),
                                                                "vat_percentage":
                                                                    _vatPercentageController
                                                                        .text,
                                                                "vat_amount":
                                                                    Decimal.parse(
                                                                        "${(vatPerc / 100 * netAmount).toPrecision(2)}"),
                                                                "total_amount": vat -
                                                                    discAmount +
                                                                    netAmount,
                                                              };
                                                              tableInvoice
                                                                      .disc =
                                                                  Decimal.parse(
                                                                      initialText);
                                                              tableInvoice
                                                                      .discPer =
                                                                  Decimal.parse(
                                                                      initialDiscPercentageText);
                                                              tableInvoice
                                                                      .netAmount =
                                                                  Decimal.parse(
                                                                      "${totalCost - double.parse(initialText).toPrecision(2)}");
                                                              tableInvoice
                                                                      .totalAmount =
                                                                  Decimal.parse(
                                                                      "${vat.toPrecision(2) + netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumSubTotal =
                                                                  Decimal.parse(
                                                                      "${netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumNetAmount =
                                                                  Decimal.parse(
                                                                      "${netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumDiscountTotal =
                                                                  Decimal.parse(
                                                                      "${double.parse(initialText).toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumVatTotal =
                                                                  Decimal.parse(
                                                                      "${vat.toStringAsFixed(2)}");
                                                              tableInvoice
                                                                      .sumTotal =
                                                                  Decimal.parse(
                                                                      "${vat.toPrecision(2) + netAmount.toPrecision(2)}");
                                                              tablesPurchaseOrder
                                                                  .add(
                                                                      tableInvoice);
                                                              itemList.add(
                                                                  tablesPurchaseOrder[
                                                                          0]
                                                                      .supItems);
                                                              setState(() {
                                                                if (selectedPurchaseOrders
                                                                    .isNotEmpty) {
                                                                  List<TablePurchaseOrder>
                                                                      temp = [];
                                                                  temp.addAll(
                                                                      selectedPurchaseOrders);
                                                                  for (TablePurchaseOrder sale
                                                                      in temp) {
                                                                    tablesPurchaseOrder
                                                                        .remove(
                                                                            sale);
                                                                    selectedPurchaseOrders
                                                                        .remove(
                                                                            sale);
                                                                    itemList
                                                                        .remove(
                                                                            sale);
                                                                  }
                                                                  editValue =
                                                                      false;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 45,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  color:
                                                                      primaryColor,
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
                                                                    ),
                                                                    Text(
                                                                        "Edit Item",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  ],
                                                                )),
                                                          ),
                                                        )
                                                      : Material(
                                                          child: InkWell(
                                                            onTap: () {
                                                              var tableInvoice =
                                                                  new TablePurchaseOrder();

                                                              tableInvoice
                                                                      .item =
                                                                  _itemController
                                                                      .text;
                                                              tableInvoice
                                                                      .bonus =
                                                                  Decimal.parse(
                                                                      _bonusController
                                                                          .text);
                                                              tableInvoice
                                                                      .totalQty =
                                                                  Decimal.parse(
                                                                      "${qty + bns}");
                                                              tableInvoice
                                                                      .quantity =
                                                                  Decimal.parse(
                                                                      _quantityController
                                                                          .text);
                                                              tableInvoice
                                                                      .netAmount =
                                                                  Decimal.parse(
                                                                      "$netAmount");
                                                              tableInvoice
                                                                      .unitPrice =
                                                                  Decimal.parse(
                                                                      _unitPriceController
                                                                          .text);
                                                              tableInvoice
                                                                      .vatAmount =
                                                                  Decimal.parse(
                                                                      "${(vatPerc / 100 * netAmount).toPrecision(2)}");
                                                              tableInvoice
                                                                      .vatPer =
                                                                  Decimal.parse(
                                                                      _vatPercentageController
                                                                          .text);
                                                              tableInvoice
                                                                  .supItems = {
                                                                "item": itemId,
                                                                "quantity":
                                                                    _quantityController
                                                                        .text,
                                                                "unit_cost":
                                                                    unitCost,
                                                                'total_cost':
                                                                    qty *
                                                                        unitCost,
                                                                "bonus":
                                                                    _bonusController
                                                                        .text,
                                                                "total_quantity":
                                                                    qty + bns,
                                                                "discount_percentage":
                                                                    Decimal.parse(
                                                                        initialDiscPercentageText),
                                                                "discount_amount":
                                                                    Decimal.parse(
                                                                        initialText),
                                                                "net_amount":
                                                                    Decimal.parse(
                                                                        "${totalCost - double.parse(initialText).toPrecision(2)}"),
                                                                "vat_percentage":
                                                                    _vatPercentageController
                                                                        .text,
                                                                "vat_amount":
                                                                    Decimal.parse(
                                                                        "${(vatPerc / 100 * netAmount).toPrecision(2)}"),
                                                                "total_amount": vat -
                                                                    discAmount +
                                                                    netAmount,
                                                              };
                                                              tableInvoice
                                                                      .disc =
                                                                  Decimal.parse(
                                                                      initialText);
                                                              tableInvoice
                                                                      .discPer =
                                                                  Decimal.parse(
                                                                      initialDiscPercentageText);
                                                              tableInvoice
                                                                      .netAmount =
                                                                  Decimal.parse(
                                                                      "${totalCost - double.parse(initialText).toPrecision(2)}");
                                                              tableInvoice
                                                                      .totalAmount =
                                                                  Decimal.parse(
                                                                      "${vat.toPrecision(2) + netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumSubTotal =
                                                                  Decimal.parse(
                                                                      "${netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumNetAmount =
                                                                  Decimal.parse(
                                                                      "${netAmount.toPrecision(2)}");
                                                              tableInvoice
                                                                      .sumDiscountTotal =
                                                                  Decimal.parse(
                                                                      "${double.parse(initialText).toPrecision(2)}");

                                                              tableInvoice
                                                                      .sumVatTotal =
                                                                  Decimal.parse(
                                                                      "${vat.toStringAsFixed(2)}");
                                                              tableInvoice
                                                                      .sumTotal =
                                                                  Decimal.parse(
                                                                      "${vat.toPrecision(2) + netAmount.toPrecision(2)}");
                                                              tablesPurchaseOrder
                                                                  .add(
                                                                      tableInvoice);
                                                              itemList.add(
                                                                  tablesPurchaseOrder[
                                                                          0]
                                                                      .supItems);

                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 45,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  color:
                                                                      primaryColor,
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
                                                                    ),
                                                                    Text(
                                                                        "Add Item",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
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
                                        ),
                                      ),
                                    ),
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
                                              selectedPurchaseOrders.isEmpty !=
                                                      true
                                                  ? Row(
                                                      children: [
                                                        InkWell(
                                                          onTap:
                                                              selectedPurchaseOrders
                                                                      .isEmpty
                                                                  ? null
                                                                  : () {
                                                                      deleteSelected();
                                                                    },
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              color: bgColor
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width: 48,
                                                                    height: 48,
                                                                    child: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red)),
                                                                Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 15.0),
                                                        InkWell(
                                                          onTap:
                                                              selectedPurchaseOrders
                                                                      .isEmpty
                                                                  ? null
                                                                  : () {
                                                                      editSelected();
                                                                    },
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              color: bgColor
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width: 48,
                                                                    height: 48,
                                                                    child: Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color:
                                                                            primaryColor)),
                                                                Text(
                                                                  "Edit",
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onSort: (columnIndex,
                                                          ascending) {
                                                        setState(() {
                                                          sort = !sort;
                                                        });
                                                        onSortColumn(
                                                            columnIndex,
                                                            ascending);
                                                      }),
                                                  DataColumn(
                                                      label: Text(
                                                    "Quantity",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Bonus",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Total Qty",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Disc",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Disc %",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Unit Cost",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Net",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "VAT",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "VAT %",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    "Total",
                                                    style: TextStyle(
                                                        color: bgColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ],
                                                rows: tablesPurchaseOrder
                                                    .map((e) => DataRow(
                                                            selected:
                                                                selectedPurchaseOrders
                                                                    .contains(
                                                                        e),
                                                            onSelectChanged:
                                                                (b) {
                                                              onSelectedRow(
                                                                  b, e);
                                                            },
                                                            cells: [
                                                              DataCell(Text(
                                                                e.item
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        bgColor,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                              DataCell(
                                                                Text(
                                                                    "${Decimal.parse(e.quantity.toString())}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            bgColor,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.bonus
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.totalQty
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.disc
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.discPer
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.unitPrice
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.netAmount
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  "${Decimal.parse(e.vatAmount.toString())}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Text(
                                                                  e.vatPer
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          bgColor,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              DataCell(Text(
                                                                e.totalAmount
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        primaryColor,
                                                                    fontSize:
                                                                        10,
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
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 3.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Subtotal",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text("Ksh${subTotalCallBack()}",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Discounts",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    "- Ksh${discountTotalCallBack()}",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Others",
                                                        style: TextStyle(
                                                          color: bgColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                padding:
                                                    const EdgeInsets.all(10.0),
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
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 28.0),
                                                        child: Text(
                                                            "Ksh ${vatTotalCallBack()}",
                                                            style: TextStyle(
                                                              color: bgColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("TOTAL",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text("Ksh${totalCallBack()}",
                                                    style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ]),
                                          SizedBox(height: 15.0),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Divider(),
                                          ),
                                          SizedBox(height: 10),
                                          InkWell(
                                            onTap: () {
                                              if (supplierId != null &&
                                                  branchId != null &&
                                                  itemList.length != 0) {
                                                SweetAlert.show(context,
                                                    title: "Confirm",
                                                    subtitle:
                                                        "Do you want to complete sale?",
                                                    style:
                                                        SweetAlertStyle.confirm,
                                                    showCancelButton: true,
                                                    confirmButtonColor:
                                                        primaryColor,
                                                    cancelButtonColor:
                                                        Colors.red,
                                                    onPress: (bool isConfirm) {
                                                  if (isConfirm) {
                                                    SweetAlert.show(
                                                      context,
                                                      subtitle: "Ordering..",
                                                      style: SweetAlertStyle
                                                          .loading,
                                                    );
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 2), () {
                                                      purchaseOrdersController
                                                          .postPurchaseOrder(
                                                              supplierId,
                                                              branchId,
                                                              double.parse(
                                                                  initialTradeText),
                                                              totalCallBack(),
                                                              discountTotalCallBack(),
                                                              myFormat.format(
                                                                  initialDate),
                                                              double.parse(
                                                                  "${tablesPurchaseOrder.map((e) => double.parse(e.sumNetAmount.toString())).fold(0, (previousValue, current) => previousValue + current)}"),
                                                              vatTotalCallBack(),
                                                              itemList,
                                                              context);
                                                      setState(() {
                                                        itemList.clear();
                                                        tablesPurchaseOrder
                                                            .clear();
                                                        _nameController.clear();
                                                        controller.clear();
                                                        _itemController.clear();
                                                        _quantityController
                                                            .clear();
                                                        _discAmountController
                                                            .clear();
                                                        _branchController
                                                            .clear();
                                                        _discPercentageController
                                                            .clear();
                                                        _unitPriceController
                                                            .clear();
                                                        _bonusController
                                                            .clear();
                                                        _tradeDiscController
                                                            .clear();
                                                        _totalQuantityController
                                                            .clear();
                                                        _vatAmountController
                                                            .clear();
                                                        _vatPercentageController
                                                            .clear();
                                                        _totalAmountController
                                                            .clear();
                                                        initialTradeText =
                                                            '0.0';
                                                        initialText = '0.0';
                                                        initialQtyText = '0.0';
                                                        initialAmountText =
                                                            "0.0";
                                                        initialDiscPercentageText =
                                                            "0.0";
                                                        initialNetText = "0.0";
                                                        initialVATAmountText =
                                                            "0.0";
                                                        _vatAmountController
                                                            .text = "0.0";
                                                        showList = true;
                                                      });
                                                      SweetAlert.show(context,
                                                          subtitle: "Success!",
                                                          style: SweetAlertStyle
                                                              .success,
                                                          confirmButtonColor:
                                                              primaryColor);
                                                    });
                                                  } else {
                                                    SweetAlert.show(context,
                                                        subtitle: "Canceled!",
                                                        style: SweetAlertStyle
                                                            .error,
                                                        confirmButtonColor:
                                                            primaryColor);
                                                  }
                                                  // return false to keep dialog
                                                  return false;
                                                });
                                              } else {
                                                null;
                                              }
                                            },
                                            child: Container(
                                              height: 40.0,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Stack(children: [
                                                Visibility(
                                                    visible: _loginFormLoading
                                                        ? false
                                                        : true,
                                                    child: Center(
                                                        child: Text(
                                                            "Complete Order",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))),
                                                Visibility(
                                                  visible: _loginFormLoading,
                                                  child: const Center(
                                                    child: SizedBox(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ),
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
                  ),
          ],
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
    // SupplierNotifier()._supplierSelected = Update.NotSelected;
    // notifyListeners();
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
          .where((branch) {
        final nameLower = branch.name.toLowerCase();
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
        'Content-type': 'application/json;charset=UTF-8',
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
