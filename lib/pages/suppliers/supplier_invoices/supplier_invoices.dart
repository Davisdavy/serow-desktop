import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/branches_controller.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/supliers_controller.dart';
import 'package:serow/controllers/supplier_invoices_controller.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/models/inventory/branch_stock.dart';
import 'package:serow/models/suppliers/purchase_orders.dart';
import 'package:serow/models/suppliers/suppliers.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/entities_repository/branches_entities_repository.dart';
import 'package:serow/repository/suppliers_repository/supplier_invoices_suppliers_repository.dart';
import 'package:serow/repository/suppliers_repository/suppliers_provider.dart';
import 'package:serow/services/services.dart';
import 'package:serow/services/suppier_invoices_data_source.dart';
import 'package:serow/widgets/custom_text.dart';

class TableInvoice {
  String quantity;
  String bonus;
  String item;
  String totalQty;
  String batchNo;
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
  String tradeDiscountPercentage;
  String sumVatTotal;
  String sumTotal;

  Map<String, dynamic> supItems;

  TableInvoice(
      {this.quantity,
      this.bonus,
      this.supItems,
      this.item,
      this.totalQty,
      this.batchNo,
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
      this.tradeDiscountPercentage,
      this.sumVatTotal,
      this.sumTotal});

  static List<TableInvoice> getTableInvoice() {
    return tablesInvoice;
  }

  static addUsers(
      quantity,
      bonus,
      item,
      totalQty,
      totalCost,
      totalAmount,
      disc,
      supItems,
      discPer,
      batchNo,
      vatAmount,
      vatPer,
      unitPrice,
      netAmount,
      sumNetAmount,
      sumSubTotal,
      sumDiscountTotal,
      tradeDiscountPercentage,
      sumVatTotal,
      sumTotal) {
    var tableInvoice = new TableInvoice();

    tableInvoice.quantity = quantity;
    tableInvoice.bonus = bonus;
    tableInvoice.item = item;
    tableInvoice.totalQty = totalQty;
    tableInvoice.totalCost = totalCost;
    tableInvoice.totalAmount = totalAmount;
    tableInvoice.disc = disc;

    tableInvoice.discPer = discPer;
    tableInvoice.vatAmount = vatAmount;
    tableInvoice.vatPer = vatPer;
    tableInvoice.unitPrice = unitPrice;
    tableInvoice.supItems = supItems;
    tableInvoice.netAmount = netAmount;
    tableInvoice.batchNo = batchNo;
    tableInvoice.sumNetAmount = sumNetAmount;
    tableInvoice.sumSubTotal = sumSubTotal;
    tableInvoice.sumDiscountTotal = sumDiscountTotal;
    tableInvoice.tradeDiscountPercentage = tradeDiscountPercentage;
    tableInvoice.sumVatTotal = sumVatTotal;
    tableInvoice.sumTotal = sumTotal;
    tablesInvoice.add(tableInvoice);
  }
}

List<TableInvoice> tablesInvoice = [];

class SupplierInvoicesPage extends StatefulWidget {
  const SupplierInvoicesPage({Key key}) : super(key: key);

  @override
  State<SupplierInvoicesPage> createState() => _SupplierInvoicesPageState();
}

class _SupplierInvoicesPageState extends State<SupplierInvoicesPage> {
  List<TableInvoice> tablesInvoice;
  List<TableInvoice> selectedInvoices;
  List<Map<String, dynamic>> itemList;
  bool sort;

  // Default Form Loading State
  bool _loginFormLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _batchNumberController = TextEditingController();
  final TextEditingController _purchaseOrderController =
      TextEditingController();
  final TextEditingController controller = new TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  TextEditingController _discAmountController;
  final TextEditingController _discPercentageController =
      TextEditingController();
  final TextEditingController _netAmountController = TextEditingController();
  final TextEditingController _unitCostController = TextEditingController();
  final TextEditingController _bonusController = TextEditingController();
  TextEditingController _vatAmountController;
  final TextEditingController _vatPercentageController =
      TextEditingController();
  TextEditingController _totalAmountController;
  TextEditingController _totalQuantityController;

  bool _isTradeEditingText = false;
  TextEditingController _tradeEditingController;
  String initialTradeText = "0";

  bool _isDateEditingText = false;
  DateTime initialDate = DateTime.now();
  DateTime expiryDate = DateTime.now();

  var myFormat = DateFormat('yyyy-MM-d');

  bool _isEditingText = false;
  String initialText = "0.0";

  bool _isQtyEditingText = false;
  String initialQtyText = "0.0";

  String initialCustomer;

  bool _isNetEditingText = false;
  String initialNetText = "0.0";

  bool _isVATAmountEditingText = false;
  String initialVATAmountText = "0.0";

  String totalValue;

  bool balanceValue = false;
  bool branchValue = false;
  bool itemValue = false;
  bool editValue = false;

  //bool purchaseValue = false;

  bool balanceQuotationValue = false;
  bool branchQuotationValue = false;
  bool itemQuotationValue = false;

  String itemId;
  String supplierId;
  String branchId;
  String purchaseOrderId;
  String batchId;

  String itemQuotationId;
  String customerQuotationId;
  String branchQuotationId;

  TypeAheadField searchTextField;
  TypeAheadField itemTextField;
  TypeAheadField branchTextField;
  TypeAheadField purchaseOrderTextField;

  double qty = 0;
  double bns = 0;
  double vat = 0;
  double netAmount = 0;
  double totalCost = 0;
  double discAmount = 0;
  double unitCost = 0;
  double discPerc = 0;
  double vatPerc = 0;

  @override
  void initState() {
    sort = false;
    selectedInvoices = [];
    itemList = [];

    _tradeEditingController = TextEditingController(text: initialText);

    tablesInvoice = TableInvoice.getTableInvoice();

    _quantityController.addListener(() {
      setState(() {
        qty = double.parse(_quantityController.text);
      });
    });

    _discAmountController.addListener(() {
      setState(() {
       discAmount =double.parse(_discAmountController.text);
      });
    });
    _discPercentageController.addListener(() {
      setState(() {
        discPerc = double.parse(_discPercentageController.text);
      });
    });

    _unitCostController.addListener(() {
      setState(() {
        unitCost = double.parse(_unitCostController.text);
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
        netAmount = double.parse(_netAmountController.text);
      });
    });

    _totalAmountController = TextEditingController(text: initialText);
    _totalQuantityController = TextEditingController(text: initialQtyText);
    _discAmountController = TextEditingController(
        text: "${discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2)}");
    _vatAmountController = TextEditingController(
        text: "${vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2)}");

    super.initState();
    //groupItemList();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        tablesInvoice.sort((a, b) => a.item.compareTo(b.item));
      } else {
        tablesInvoice.sort((a, b) => b.item.compareTo(a.item));
      }
    }
  }

  onSelectedRow(bool selected, TableInvoice sale) async {
    setState(() {
      if (selected) {
        selectedInvoices.add(sale);
      } else {
        selectedInvoices.remove(sale);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedInvoices.isNotEmpty) {
        List<TableInvoice> temp = [];
        temp.addAll(selectedInvoices);
        for (TableInvoice sale in temp) {
          tablesInvoice.remove(sale);
          selectedInvoices.remove(sale);
        }
      }
    });
  }

  editSelected() async {
    setState(() {
      if (selectedInvoices.isNotEmpty) {
        List<TableInvoice> temp = [];
        temp.addAll(selectedInvoices);
        for (TableInvoice sale in temp) {
          _quantityController.text = sale.quantity;
          _itemController.text = sale.item;
          _bonusController.text = sale.bonus;
          _totalQuantityController.text = sale.totalQty;
          _discAmountController.text = sale.disc;
          _discPercentageController.text = sale.discPer;
          _vatAmountController.text = sale.vatAmount;
          _vatPercentageController.text = sale.vatPer;
          editValue = true;

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
          "${discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2)}",
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
          "${totalCost.toPrecision(2) - discAmount.toPrecision(2)}",
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
          "${vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
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

  Widget _editExpiryDateDiscountTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child:
              Text("${expiryDate.year}-${expiryDate.month}-${expiryDate.day}"),
        ),
        TextButton(
            onPressed: () {
              _selectExpiryDate(context);
            },
            child: Text('Select Date')

            //hintText: ('${myFormat.format(initialDate)}'),
            ),
      ],
    );
    //));
  }

  Widget _editTradeDiscountTextField(String text) {
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
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editDiscountPercentageTextField(String text) {
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
          text,
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
    _tradeEditingController.dispose();
    controller.dispose();
    _itemController.dispose();
    _quantityController.dispose();
    _discAmountController.dispose();
    _branchController.dispose();
    _discPercentageController.dispose();
    _netAmountController.dispose();
    _unitCostController.dispose();
    _bonusController.dispose();
    _totalQuantityController.dispose();
    _vatAmountController.dispose();
    _batchNumberController.dispose();
    _vatPercentageController.dispose();
    _purchaseOrderController.dispose();
    _totalAmountController.dispose();
    _quantityController.removeListener(() {});
    _unitCostController.removeListener(() {});

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

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: expiryDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    setState(() {
      expiryDate = picked ?? expiryDate;
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

  @override
  Widget build(BuildContext context) {
    totalCost = unitCost.toPrecision(2) * qty;
    discAmount = discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2);
    vat = vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2);
    netAmount = totalCost.toPrecision(2) - discAmount.toPrecision(2);

    // discPerc = discAmount / totalCost.toPrecision(2) * 100;

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
    purchaseOrderTextField = TypeAheadField<PurchaseOrders>(
      suggestionsCallback: PurchaseOrderApi.getBranchSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._purchaseOrderController,
        decoration: InputDecoration(
            hintText: "Purchase order",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final order = suggestion;
        return ListTile(
          title: Text(order.code),
        );
      },
      onSuggestionSelected: (PurchaseOrders suggestion) {
        this._purchaseOrderController.text = suggestion.code;
        purchaseOrderId = suggestion.id;
        _nameController.text =
            "${PurchaseOrderApi.purchaseOrderList[0].supplier.name}";
        _branchController.text =
            "${PurchaseOrderApi.purchaseOrderList[0].branch.name}";
        var tableInvoice = new TableInvoice();
        tableInvoice.tradeDiscountPercentage =
            "${PurchaseOrderApi.purchaseOrderList[0].tradeDiscountPercentage}";
        tableInvoice.item =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].item.name}";
        tableInvoice.quantity =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].quantity}";
        tableInvoice.bonus =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].bonus}";
        tableInvoice.totalQty =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].totalQuantity}";
        tableInvoice.disc =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountAmount}";
        tableInvoice.discPer =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountPercentage}";
        tableInvoice.unitPrice =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].unitCost}";
        tableInvoice.netAmount =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].netAmount}";
        tableInvoice.vatAmount =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount}";
        tableInvoice.batchNo = _batchNumberController.text;
        tableInvoice.vatPer =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatPercentage}";
        tableInvoice.totalCost =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].totalCost}";
        tableInvoice.totalAmount =
            "${PurchaseOrderApi.purchaseOrderList[0].totalAmount}";
        tableInvoice.sumSubTotal =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountAmount +
                PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].netAmount - PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount} ";
        tableInvoice.sumNetAmount =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].netAmount}";
        tableInvoice.sumDiscountTotal =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountAmount}";
        tableInvoice.sumVatTotal =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount}";
        tableInvoice.sumTotal =
            "${PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount -
                PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountAmount +
                PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].netAmount -
                PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount}";
        tableInvoice.supItems =
        {
          "item": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].item.id,
          "quantity": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].quantity,
          "unit_cost":PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].unitCost,
          'total_cost': PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].totalCost,
          "bonus": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].bonus,
          "total_quantity":PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].totalQuantity,
          'expiry_date':
          myFormat.format(
              expiryDate),
          "discount_percentage": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountPercentage,
          "discount_amount": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].discountAmount,
          "net_amount":PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].netAmount,
          "vat_percentage": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatPercentage,
          "vat_amount": PurchaseOrderApi.purchaseOrderList[0].purchaseOrderItems[0].vatAmount,
          "total_amount": PurchaseOrderApi.purchaseOrderList[0].totalAmount,
        };
        tablesInvoice.add(tableInvoice);
        itemList.add(
            tablesInvoice[0]
                .supItems);
        setState(() {});

      },
      noItemsFoundBuilder: (context) =>
          Center(child: Text("No purchase order found!")),
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
              height: MediaQuery.of(context).size.height / 1.25,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Material(
                                                      child: Text(
                                                    "Purchase Order",
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
                                                      child:
                                                          purchaseOrderTextField,
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
                                                      child: balanceValue ==
                                                              true
                                                          ? Text(
                                                              "Ksh ${SupplierApi.customersList[0].creditLimit}",
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
                                                        child:
                                                            balanceValue == true
                                                                ? Text(
                                                                    "Ksh ${SupplierApi.customersList[0].balance}",
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
                                            ),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Material(
                                                      child: Text(
                                                    "Received Date",
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
                                                        _editDateReceivedDiscountTextField(),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
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
                                                    "Supplier",
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
                                                    "Trade Disc",
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
                                                        _editTradeDiscountTextField(
                                                            initialTradeText),
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
                                                      "Last Pay Amount",
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
                                                        child: balanceValue ==
                                                                true
                                                            //     ? Text(
                                                            //         "Ksh${PurchaseOrderApi.purchaseOrderList[0].totalAmount.toString()}",
                                                            //         style: TextStyle(
                                                            //             color: Colors
                                                            //                 .red,
                                                            //             fontSize: 8,
                                                            //             fontWeight:
                                                            //                 FontWeight
                                                            //                     .bold),
                                                            //       )
                                                            //     :
                                                            ? Text(
                                                                "Ksh${SupplierApi.customersList[0].lastPayAmount}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                "Ksh0.0",
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
                                                  Material(
                                                      child: Text(
                                                    "Posting Category",
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
                                                          //     ? Text(
                                                          //         "${PurchaseOrderApi.purchaseOrderList[0].expectedDate.toString()}",
                                                          //         style: TextStyle(
                                                          //             color: Colors
                                                          //                 .red,
                                                          //             fontSize: 8,
                                                          //             fontWeight:
                                                          //                 FontWeight
                                                          //                     .bold),
                                                          //       )
                                                          //     :
                                                          ? Text(
                                                              SupplierApi
                                                                  .customersList[
                                                                      0]
                                                                  .postingCategory
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              'Category',
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
                                                        "Contact Number",
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
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                      child: Material(
                                                          child: balanceValue ==
                                                                  true
                                                              //     ? Text(
                                                              //         "Ksh ${PurchaseOrderApi.purchaseOrderList[0].noOfItems.toString()}",
                                                              //         style: TextStyle(
                                                              //             color: Colors
                                                              //                 .red,
                                                              //             fontSize:
                                                              //                 8,
                                                              //             fontWeight:
                                                              //                 FontWeight.bold),
                                                              //       )
                                                              //     :
                                                              ? Text(
                                                                  SupplierApi
                                                                      .customersList[
                                                                          0]
                                                                      .phone,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text(
                                                                  'Number',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          8,
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
                                                      "Search item",
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
                                                  Material(
                                                    child: Flexible(
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
                                                    "Expiry Date",
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
                                                        _editExpiryDateDiscountTextField(),
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
                                                    "Batch",
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
                                                            _batchNumberController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        // inputFormatters: [
                                                        //   FilteringTextInputFormatter
                                                        //       .allow(RegExp(
                                                        //       r'^\d*\.?\d{0,2}')),
                                                        // ],
                                                        decoration:
                                                            InputDecoration(
                                                                //  labelText: "Email Address",
                                                                hintText: "  -",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
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
                                                                hintText: "  0",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
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
                                                            _unitCostController,
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
                                                                  fontSize: 12,
                                                                ),
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
                                                                hintText: "  0",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
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
                                                                  fontSize: 12,
                                                                ),
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
                                                                hintText:
                                                                    "  0.0",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
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
                                                        "${vat - discAmount + netAmount}",
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
                                            editValue == true
                                                ? Material(
                                                    child: InkWell(
                                                      onTap: () {
                                                        var tableInvoice =
                                                            new TableInvoice();
                                                        tableInvoice.totalCost =
                                                            "${qty * double.parse(_unitCostController.text)}";
                                                        tableInvoice.item =
                                                            _itemController
                                                                .text;
                                                        tableInvoice.bonus =
                                                            _bonusController
                                                                .text;
                                                        tableInvoice.totalQty =
                                                            "${qty + bns}";
                                                        tableInvoice.quantity =
                                                            _quantityController
                                                                .text;
                                                        tableInvoice.netAmount =
                                                            _netAmountController
                                                                .text;
                                                        tableInvoice.unitPrice =
                                                            _unitCostController
                                                                .text;
                                                        tableInvoice.vatAmount =
                                                            "${vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2)}";
                                                        tableInvoice.vatPer =
                                                            _vatPercentageController
                                                                .text;
                                                        tableInvoice.batchNo =
                                                            _batchNumberController
                                                                .text;
                                                        tableInvoice.supItems =
                                                            {
                                                          "item": itemId,
                                                          "quantity":
                                                              _quantityController
                                                                  .text,
                                                          "unit_cost":
                                                              unitCost,
                                                          'total_cost': qty +
                                                              bns *
                                                                  double.parse(
                                                                      _unitCostController
                                                                          .text),
                                                          "bonus":
                                                              _bonusController
                                                                  .text,
                                                          "total_quantity":
                                                              qty + bns,
                                                          'expiry_date':
                                                              myFormat.format(
                                                                  expiryDate),
                                                          'batch_number':
                                                              _batchNumberController
                                                                  .text,
                                                          "discount_percentage":
                                                              _discPercentageController
                                                                  .text,
                                                          "discount_amount": discPerc
                                                                  .toPrecision(
                                                                      2) /
                                                              100 *
                                                              totalCost
                                                                  .toPrecision(
                                                                      2),
                                                          "net_amount":
                                                              totalCost -
                                                                  discAmount,
                                                          "vat_percentage":
                                                              _vatPercentageController
                                                                  .text,
                                                          "vat_amount": vatPerc
                                                                  .toPrecision(
                                                                      2) /
                                                              100 *
                                                              netAmount
                                                                  .toPrecision(
                                                                      2),
                                                          "total_amount": vat -
                                                              discAmount +
                                                              netAmount,
                                                        };
                                                        tableInvoice.disc =
                                                            "${discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2)}";
                                                        tableInvoice.discPer =
                                                            _discPercentageController
                                                                .text;
                                                        tableInvoice
                                                                .tradeDiscountPercentage =
                                                            _tradeEditingController
                                                                    .value
                                                                    .text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : _tradeEditingController
                                                                    .text;
                                                        tableInvoice.netAmount =
                                                            "${totalCost - discAmount}";
                                                        tableInvoice
                                                                .totalAmount =
                                                            "${vat + netAmount}";
                                                        tableInvoice
                                                                .sumSubTotal =
                                                            "${vat.toPrecision(2) - discAmount.toPrecision(2) + netAmount.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumNetAmount =
                                                            "${netAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumDiscountTotal =
                                                            "${discAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumVatTotal =
                                                            "${vat.toPrecision(2)}";
                                                        tableInvoice.sumTotal =
                                                            "${vat.toPrecision(2) - discAmount.toPrecision(2) + netAmount.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2) + vat.toPrecision(2) - discAmount.toPrecision(2)}";
                                                        tablesInvoice
                                                            .add(tableInvoice);
                                                        itemList.add(
                                                            tablesInvoice[0]
                                                                .supItems);
                                                        setState(() {
                                                          if(selectedInvoices.isNotEmpty) {
                                                            List<
                                                                TableInvoice> temp = [
                                                            ];
                                                            temp.addAll(
                                                                selectedInvoices);
                                                            for (TableInvoice sale in temp) {
                                                              tablesInvoice
                                                                  .remove(sale);
                                                              selectedInvoices
                                                                  .remove(sale);
                                                            }
                                                            editValue = false;
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
                                                            color: primaryColor,
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
                                                              Text("Edit Item",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ],
                                                          )),
                                                    ),
                                                  )
                                                : Material(
                                                    child: InkWell(
                                                      onTap: () {
                                                        var tableInvoice =
                                                            new TableInvoice();
                                                        tableInvoice.totalCost =
                                                            "${qty * double.parse(_unitCostController.text)}";
                                                        tableInvoice.item =
                                                            _itemController
                                                                .text;
                                                        tableInvoice.bonus =
                                                            _bonusController
                                                                .text;
                                                        tableInvoice.totalQty =
                                                            "${qty + bns}";
                                                        tableInvoice.quantity =
                                                            _quantityController
                                                                .text;
                                                        tableInvoice.netAmount =
                                                            _netAmountController
                                                                .text;
                                                        tableInvoice.unitPrice =
                                                            _unitCostController
                                                                .text;
                                                        tableInvoice.vatAmount =
                                                            "${vatPerc.toPrecision(2) / 100 * netAmount.toPrecision(2)}";
                                                        tableInvoice.vatPer =
                                                            _vatPercentageController
                                                                .text;
                                                        tableInvoice.batchNo =
                                                            _batchNumberController
                                                                .text;
                                                        tableInvoice.supItems =
                                                            {
                                                          "item": itemId,
                                                          "quantity":
                                                              _quantityController
                                                                  .text,
                                                          "unit_cost":
                                                              unitCost,
                                                          'total_cost': qty +
                                                              bns *
                                                                  double.parse(
                                                                      _unitCostController
                                                                          .text),
                                                          "bonus":
                                                              _bonusController
                                                                  .text,
                                                          "total_quantity":
                                                              qty + bns,
                                                          'expiry_date':
                                                              myFormat.format(
                                                                  expiryDate),
                                                          'batch_number':
                                                              _batchNumberController
                                                                  .text,
                                                          "discount_percentage":
                                                              _discPercentageController
                                                                  .text,
                                                          "discount_amount": discPerc
                                                                  .toPrecision(
                                                                      2) /
                                                              100 *
                                                              totalCost
                                                                  .toPrecision(
                                                                      2),
                                                          "net_amount":
                                                              totalCost -
                                                                  discAmount,
                                                          "vat_percentage":
                                                              _vatPercentageController
                                                                  .text,
                                                          "vat_amount": vatPerc
                                                                  .toPrecision(
                                                                      2) /
                                                              100 *
                                                              netAmount
                                                                  .toPrecision(
                                                                      2),
                                                          "total_amount": vat -
                                                              discAmount +
                                                              netAmount,
                                                        };
                                                        tableInvoice.disc =
                                                            "${discPerc.toPrecision(2) / 100 * totalCost.toPrecision(2)}";
                                                        tableInvoice.discPer =
                                                            _discPercentageController
                                                                .text;
                                                        tableInvoice
                                                                .tradeDiscountPercentage =
                                                            _tradeEditingController
                                                                    .value
                                                                    .text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : _tradeEditingController
                                                                    .text;
                                                        tableInvoice.netAmount =
                                                            "${totalCost - discAmount}";
                                                        tableInvoice
                                                                .totalAmount =
                                                            "${vat + netAmount}";
                                                        tableInvoice
                                                                .sumSubTotal =
                                                            "${vat.toPrecision(2) - discAmount.toPrecision(2) + netAmount.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumNetAmount =
                                                            "${netAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumDiscountTotal =
                                                            "${discAmount.toPrecision(2)}";
                                                        tableInvoice
                                                                .sumVatTotal =
                                                            "${vat.toPrecision(2)}";
                                                        tableInvoice.sumTotal =
                                                            "${vat.toPrecision(2) - discAmount.toPrecision(2) + netAmount.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2) + vat.toPrecision(2) - discAmount.toPrecision(2)}";
                                                        tablesInvoice
                                                            .add(tableInvoice);
                                                        itemList.add(
                                                            tablesInvoice[0]
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
                                                            color: primaryColor,
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
                                  ),
                                ),
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
                                        selectedInvoices.isEmpty != true
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap:
                                                        selectedInvoices.isEmpty
                                                            ? null
                                                            : () {
                                                                deleteSelected();
                                                              },
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
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
                                                                  color: Colors
                                                                      .red)),
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
                                                  ),
                                                  SizedBox(width: 15.0),
                                                  InkWell(
                                                    onTap:
                                                        selectedInvoices.isEmpty
                                                            ? null
                                                            : () {
                                                                editSelected();
                                                              },
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: bgColor
                                                            .withOpacity(0.2),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: 48,
                                                              height: 48,
                                                              child: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                      primaryColor)),
                                                          Text(
                                                            "Edit",
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
                                                ],
                                              )
                                            : Container(),
                                        /*
                                        Todo:Add Edit button that will trigger edit and delete functionalities
                                         */
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
                                          rows: tablesInvoice
                                              .map((e) => DataRow(
                                                      selected: selectedInvoices
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
                                                          Text(e.quantity,
                                                              style: TextStyle(
                                                                  color:
                                                                      bgColor,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            e.bonus,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            e.totalQty,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            e.disc,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            e.discPer,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            e.unitPrice,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          TextFormField(
                                                            initialValue:
                                                                e.netAmount,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
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
                                                            ),
                                                            showEditIcon: true),
                                                        DataCell(
                                                          Text(
                                                            e.vatPer,
                                                            style: TextStyle(
                                                                color: bgColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
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
                                              "Ksh${tablesInvoice.map((e) => double.parse(e.sumSubTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "- Ksh${tablesInvoice.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                                      "Ksh ${tablesInvoice.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "Ksh${tablesInvoice.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                    InkWell(
                                      onTap: () {
                                        // print('${tablesInvoice[0].stringItems}');
                                        setState(() {
                                          _loginFormLoading = true;
                                        });

                                        /*
                                        Check invoice items object for a successful post
                                         */
                                        // if (_nameController
                                        //         .value.text.isNotEmpty &&
                                        //     _branchController
                                        //         .value.text.isNotEmpty) {
                                        if (supplierId == null &&
                                            branchId == null &&
                                            itemId == null) {
                                          itemId = PurchaseOrderApi
                                              .purchaseOrderList[0]
                                              .purchaseOrderItems[0]
                                              .item
                                              .id;
                                          supplierId = PurchaseOrderApi
                                              .purchaseOrderList[0].supplier.id;
                                          branchId = PurchaseOrderApi
                                              .purchaseOrderList[0].branch.id;
                                          supplierInvoicesController.postNewSupplierInvoice(
                                              supplierId,
                                              branchId,
                                              purchaseOrderId,
                                              double.parse(tablesInvoice[0]
                                                  .tradeDiscountPercentage),
                                              myFormat.format(initialDate),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              "posted",
                                              itemList,
                                              context);

                                          _successAlertDialogBuilder(
                                              'Successfully saved invoice');
                                          setState(() {
                                            _loginFormLoading = false;
                                          });
                                        } else if (supplierId != null &&
                                            branchId != null &&
                                            itemId != null) {
                                          supplierInvoicesController.postNewSupplierInvoice(
                                              supplierId,
                                              branchId,
                                              purchaseOrderId,
                                              double.parse(tablesInvoice[0]
                                                  .tradeDiscountPercentage),
                                              myFormat.format(initialDate),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              double.parse(
                                                  "${tablesInvoice.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                              "posted",
                                              itemList,
                                              context);

                                          _successAlertDialogBuilder(
                                              'Successfully saved invoice');
                                          setState(() {
                                            _loginFormLoading = false;
                                          });
                                        } else {
                                          _alertDialogBuilder(
                                              'Make sure branch and supplier name is provided');
                                          _loginFormLoading = false;
                                        }
                                        // else if (supplierId == null &&
                                        //     branchId == null &&
                                        //     itemId == null &&
                                        //     _nameController
                                        //         .value.text.isNotEmpty &&
                                        //     _branchController
                                        //         .value.text.isNotEmpty && _itemController.value.text.isNotEmpty) {}
                                      },
                                      child: Container(
                                        height: 40.0,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                  child: Text("Complete Sale",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white)))),
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

class PurchaseOrderApi {
  static List<PurchaseOrders> purchaseOrderList = <PurchaseOrders>[];

  static Future<List<PurchaseOrders>> getBranchSuggestions(
      String query, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final response = await http.get(
      Uri.parse('${AppUrl.purchase_orders}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    if (response.statusCode == 200) {
      final Map customers = json.decode(response.body);
      var categoryJson = customers['results'] as List;
      print("Json purchase order: ${categoryJson[0]['purchase_order_items']}");

      for (int i = 0; i < categoryJson.length; i++) {
        purchaseOrderList.add(new PurchaseOrders.fromJson(categoryJson[i]));
      }
      return categoryJson
          .map((json) => PurchaseOrders.fromJson(json))
          .where((purchaseOrder) {
        final nameLower = purchaseOrder.code.toLowerCase();
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
