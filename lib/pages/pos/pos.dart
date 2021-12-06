import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:serow/constants.dart';
import 'package:serow/controllers/controller.dart';
import 'package:serow/controllers/quotation_controller.dart';
import 'package:serow/controllers/sales_controller.dart';
import 'package:serow/models/auth/auth.dart';
import 'package:serow/models/customers/customers.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/models/inventory/branch_stock.dart';
import 'package:serow/repository/auth_provider.dart';
import 'package:serow/repository/pos_repository/quotation_pos_repository.dart';
import 'package:serow/repository/pos_repository/sales_pos_repository.dart';
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
  String unitPrice;
  String netAmount;
  String sumNetAmount;
  String sumSubTotal;
  String sumDiscountTotal;
  String sumVatTotal;
  String sumTotal;

  TableSale(
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

  static List<TableSale> getTableSale() {
    return tablesSale;
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
    tableSale.unitPrice = unitPrice;
    tableSale.netAmount = netAmount;
    tableSale.sumNetAmount = sumNetAmount;
    tableSale.sumSubTotal = sumSubTotal;
    tableSale.sumDiscountTotal = sumDiscountTotal;
    tableSale.sumVatTotal = sumVatTotal;
    tableSale.sumTotal = sumTotal;
    tablesSale.add(tableSale);
  }
}
class TableQuotation {
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
  String sumDiscountPercentage;
  String sumVatTotal;
  String sumTotal;

  TableQuotation(
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
        this.sumDiscountPercentage,
        this.sumVatTotal,
        this.sumTotal});

  static List<TableQuotation> getTableQuotation() {
    return tablesQuotation;
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
      sumDiscountPercentage,
      sumVatTotal,
      sumTotal) {
    var tableQuotation = new TableQuotation();
    tableQuotation.quantity = quantity;
    tableQuotation.bonus = bonus;
    tableQuotation.item = item;
    tableQuotation.totalQty = totalQty;
    tableQuotation.totalCost = totalCost;
    tableQuotation.totalAmount = totalAmount;
    tableQuotation.disc = disc;
    tableQuotation.discPer = discPer;
    tableQuotation.vatAmount = vatAmount;
    tableQuotation.vatPer = vatPer;
    tableQuotation.unitPrice = unitPrice;
    tableQuotation.netAmount = netAmount;
    tableQuotation.sumNetAmount = sumNetAmount;
    tableQuotation.sumSubTotal = sumSubTotal;
    tableQuotation.sumDiscountTotal = sumDiscountTotal;
    tableQuotation.sumDiscountPercentage = sumDiscountPercentage;
    tableQuotation.sumVatTotal = sumVatTotal;
    tableQuotation.sumTotal = sumTotal;
    tablesQuotation.add(tableQuotation);
  }
}
List<TableSale> tablesSale = [];
List<TableQuotation> tablesQuotation = [];

class POSPage extends StatefulWidget {
  const POSPage({Key key}) : super(key: key);

  @override
  _POSPageState createState() => _POSPageState();
}

class _POSPageState extends State<POSPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<TableSale> tablesSale;
  List<TableSale> selectedSales;
  List<TableQuotation> tablesQuotation;
  List<TableQuotation> selectedQuotations;
  bool sort;
  bool sortQuotation;


  /*
  Sales Controller
   */
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

  /*
  Ends here
   */

  /*
  Quotation Controllers
   */
  final TextEditingController _quotNameController = TextEditingController();
  final TextEditingController _quotItemController = TextEditingController();
  final TextEditingController _quotBranchController = TextEditingController();
  final TextEditingController quotController = new TextEditingController();
  final TextEditingController _quotQuantityController = TextEditingController();
  TextEditingController _quotDiscAmountController;
  final TextEditingController _quotDiscPercentageController =
  TextEditingController();
  final TextEditingController _quotNetAmountController = TextEditingController();
  final TextEditingController _quotUnitPriceController = TextEditingController();
  final TextEditingController _quotBonusController = TextEditingController();
  TextEditingController _quotVatAmountController;
  final TextEditingController _quotVatPercentageController =
  TextEditingController();
  TextEditingController _quotTotalAmountController;
  TextEditingController _quotTotalQuantityController;

  /*
  Ends Here
   */

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
  String customerId;
  String branchId;

  String itemQuotationId;
  String customerQuotationId;
  String branchQuotationId;

  /*
  Sales typeAhead
   */
  TypeAheadField searchTextField;
  TypeAheadField itemTextField;
  TypeAheadField branchTextField;

  /*
  Quotation typeAhead
   */
  TypeAheadField searchQuotationTextField;
  TypeAheadField itemQuotationTTextField;
  TypeAheadField branchQuotationTTextField;

  /*
  Sales initial values
   */

  double qty = 0;
  double bns = 0;
  double vat = 0;
  double netPrice = 0;
  double itemPrice = 0;
  double discAmount = 0;
  double unitPrice = 0;
  double discPerc = 0;
  double vatPerc = 0;

  /*
  Quotation initial values
   */
  double quotQty = 0;
  double quotBns = 0;
  double quotVat = 0;
  double quotNetPrice = 0;
  double quotItemPrice = 0;
  double quotDiscAmount = 0;
  double quotUnitPrice = 0;
  double quotDiscPerc = 0;
  double quotVatPerc = 0;

  /*
  Item price = unit price * quantity

  Discount amount = discount percentage / 100 * item price

  Net amount = item price - discount amount

  VAT amount = VAT percentage / 100 * net amount

  Total Amount =  VAT amount - discount amount + net amount

   */

  @override
  bool get wantKeepAlive => true;

  final List<Tab> myTabs = <Tab>[
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
  ];

  @override
  void initState() {
    sort = false;
    sortQuotation = false;

    selectedSales = [];
    selectedQuotations = [];

    tablesSale = TableSale.getTableSale();
    tablesQuotation = TableQuotation.getTableQuotation();
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: myTabs.length);
    // loadData();

    _quantityController.addListener(() {
      setState(() {
        qty = double.parse(_quantityController.text);
      });
    });

    _quotQuantityController.addListener(() {
      setState(() {
        quotQty = double.parse(_quotQuantityController.text);
      });
    });

    _discPercentageController.addListener(() {
      setState(() {
        discPerc = double.parse(_discPercentageController.text);
      });
    });

    _quotDiscPercentageController.addListener(() {
      setState(() {
        quotDiscPerc = double.parse(_quotDiscPercentageController.text);
      });
    });

    _unitPriceController.addListener(() {
      setState(() {
        unitPrice = double.parse(_unitPriceController.text);
      });
    });

    _quotUnitPriceController.addListener(() {
      setState(() {
        quotUnitPrice = double.parse(_quotUnitPriceController.text);
      });
    });

    _bonusController.addListener(() {
      setState(() {
        bns = double.parse(_bonusController.text);
      });
    });

    _quotBonusController.addListener(() {
      setState(() {
        quotBns = double.parse(_quotBonusController.text);
      });
    });

    _vatPercentageController.addListener(() {
      setState(() {
        vatPerc = double.parse(_vatPercentageController.text);
      });
    });

    _quotVatPercentageController.addListener(() {
      setState(() {
        quotVatPerc = double.parse(_quotVatPercentageController.text);
      });
    });

    _netAmountController.addListener(()  {
      setState(() {
        netPrice = double.parse(_netAmountController.text);
      });
    });

    _quotNetAmountController.addListener(()  {
      setState(() {
        quotNetPrice = double.parse(_quotNetAmountController.text);
      });
    });

    _totalAmountController = TextEditingController(text: initialText);
    _totalQuantityController = TextEditingController(text: initialQtyText);
    _discAmountController = TextEditingController(
        text: "${discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2)}");
    _vatAmountController = TextEditingController(
        text: "${vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2)}");

    _quotTotalAmountController = TextEditingController(text: initialText);
    _quotTotalQuantityController = TextEditingController(text: initialQtyText);
    _quotDiscAmountController = TextEditingController(
        text: "${quotDiscPerc.toPrecision(2) / 100 * quotItemPrice.toPrecision(2)}");
    _quotVatAmountController = TextEditingController(
        text: "${quotVatPerc.toPrecision(2) / 100 * quotNetPrice.toPrecision(2)}");
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

  onSortColumnQuotation(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        tablesQuotation.sort((a, b) => a.item.compareTo(b.item));
      } else {
        tablesQuotation.sort((a, b) => b.item.compareTo(a.item));
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

  onSelectedRowQuotation(bool selected, TableQuotation quotation) async {
    setState(() {
      if (selected) {
        selectedQuotations.add(quotation);
      } else {
        selectedQuotations.remove(quotation);
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

  deleteSelectedQuotation() async {
    setState(() {
      if (selectedQuotations.isNotEmpty) {
        List<TableQuotation> temp = [];
        temp.addAll(selectedQuotations);
        for (TableQuotation quotation in temp) {
          tablesQuotation.remove(quotation);
          selectedQuotations.remove(quotation);
        }
      }
    });
  }

  // void loadData() async {
  //   await CustomersViewModel.loadCustomers(context);
  //   await ItemsViewModel.loadItems(context);
  //   await BranchesViewModel.loadBranches(context);
  // }

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

  Widget _editDiscTextField() {
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
                  _quotDiscAmountController.text = newValue;
                  _isEditingText = false;
                });
              },
              autofocus: true,
              controller: _quotDiscAmountController,
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
          "${quotDiscPerc.toPrecision(2) / 100 * quotItemPrice.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editQuotNetTextField() {
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
              controller: _quotNetAmountController,
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
          "${quotItemPrice.toPrecision(2) - quotDiscAmount.toPrecision(2)}",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _editQuotVATAmountTextField() {
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
              controller: _quotVatAmountController,
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
          "${quotVatPerc.toPrecision(2) / 100 * quotNetPrice.toPrecision(2)}",
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
    _tabController.dispose();
    _quantityController.removeListener(() { });
    _unitPriceController.removeListener(() { });


    _quotNameController.dispose();
     _quotItemController.dispose();
    _quotBranchController.dispose();
      quotController.dispose();
      _quotQuantityController.dispose();
     _quotDiscAmountController.dispose();
      _quotDiscPercentageController.dispose();
      _quotNetAmountController.dispose();
   _quotUnitPriceController.dispose();
     _quotBonusController.dispose();
     _quotVatAmountController.dispose();
      _quotVatPercentageController.dispose();
     _quotTotalAmountController.dispose();
     _quotTotalQuantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    itemPrice = unitPrice.toPrecision(2) * qty;
    discAmount = discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2);
    vat = vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2);
    netPrice = itemPrice.toPrecision(2) - discAmount.toPrecision(2);

    quotItemPrice = quotUnitPrice.toPrecision(2) * quotQty;
    quotDiscAmount = quotDiscPerc.toPrecision(2) / 100 * quotItemPrice.toPrecision(2);
    quotVat = quotVatPerc.toPrecision(2) / 100 * quotNetPrice.toPrecision(2);
    quotNetPrice = quotItemPrice.toPrecision(2) - quotDiscAmount.toPrecision(2);

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
    searchTextField = TypeAheadField<Customers>(
      suggestionsCallback: CustomerApi.getCustomersSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._nameController,
        decoration: InputDecoration(
            hintText: "Search customer",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final customer = suggestion;
        return ListTile(
          title: Text(customer.name),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._nameController.text = suggestion.name;
        customerId = suggestion.id;
        setState(() {
          balanceValue = true;
        });
      },
      noItemsFoundBuilder: (context) =>
          Center(child: Text("No customer found!")),
    );

    searchQuotationTextField = TypeAheadField<Customers>(
      suggestionsCallback: CustomerApi.getCustomersSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._quotNameController,
        decoration: InputDecoration(
            hintText: "Search customer",
            hintStyle: TextStyle(fontSize: 12),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primaryColor, width: 0.4),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5))),
      ),
      itemBuilder: (context, suggestion) {
        final customer = suggestion;
        return ListTile(
          title: Text(customer.name),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._quotNameController.text = suggestion.name;
        customerQuotationId = suggestion.id;
        setState(() {
          balanceQuotationValue = true;
        });
      },
      noItemsFoundBuilder: (context) =>
          Center(child: Text("No customer found!")),
    );
    itemQuotationTTextField = TypeAheadField<BranchStock>(
      suggestionsCallback: ItemApi.getItemSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._quotItemController,
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
        this._quotItemController.text = suggestion.item.name;
        itemQuotationId = suggestion.item.id;
        setState(() {
          itemQuotationValue = true;
        });
      },
      noItemsFoundBuilder: (context) => Center(child: Text("No item found!")),
    );
    branchQuotationTTextField = TypeAheadField<Branches>(
      suggestionsCallback: BranchApi.getBranchSuggestions,
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._quotBranchController,
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
        this._quotBranchController.text = suggestion.name;
        branchQuotationId = suggestion.id;
      },
      noItemsFoundBuilder: (context) => Center(child: Text("No branch found!")),
    );

    var salesController = SalesController(SalesPOSRepository());
    var quotationController = QuotationController(QuotationPOSRepository());
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
                tabs: myTabs,
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
                                                            "Ksh ${CustomerApi.customersList[0].creditLimit}",
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
                                                              "Ksh ${CustomerApi.customersList[0].balance}",
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
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                var tableSale = new TableSale();

                                                tableSale.item = _itemController.text;
                                                tableSale.bonus = _bonusController.text;
                                                tableSale.totalQty = "${qty + bns}";
                                                tableSale.quantity = _quantityController.text;
                                                tableSale.netAmount = _netAmountController.text;
                                                tableSale.unitPrice = _unitPriceController.text;
                                                tableSale.vatAmount = "${vatPerc.toPrecision(2) / 100 * netPrice.toPrecision(2)}";
                                                tableSale.vatPer = _vatPercentageController.text;
                                                tableSale.disc = "${discPerc.toPrecision(2) / 100 * itemPrice.toPrecision(2)}";
                                                tableSale.discPer = _discPercentageController.text;
                                                tableSale.netAmount = "${itemPrice - discAmount}";
                                                tableSale.totalAmount = "${vat - discAmount + netPrice}";
                                                tableSale.sumSubTotal = "${vat.toPrecision(2) - discAmount.toPrecision(2) + netPrice.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2)}";
                                                tableSale.sumNetAmount = "${netPrice.toPrecision(2)}";
                                                tableSale.sumDiscountTotal = "${discAmount.toPrecision(2)}";
                                                tableSale.sumVatTotal = "${vat.toPrecision(2)}";
                                                tableSale.sumTotal = "${vat.toPrecision(2) - discAmount.toPrecision(2) + netPrice.toPrecision(2) - vat.toPrecision(2) + discAmount.toPrecision(2) + vat.toPrecision(2) - discAmount.toPrecision(2)}";
                                                tablesSale.add(tableSale);
                                                setState(() {

                                                });

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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        selectedSales.isEmpty != true
                                            ? InkWell(
                                                onTap: selectedSales.isEmpty
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
                                          rows: tablesSale
                                              .map((e) => DataRow(
                                                      selected: selectedSales
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
                                              "Ksh${tablesSale.map((e) => double.parse(e.sumSubTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "- Ksh${tablesSale.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                                      "Ksh ${tablesSale.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "Ksh${tablesSale.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                      onTap: () async {

                                        salesController.postSales(
                                            customerId,
                                            branchId,
                                            "posted",
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            itemId,
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.quantity)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.unitPrice)).fold(0, (previousValue, element) => previousValue + element)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.bonus)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.totalQty)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.discPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.disc)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.netAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.vatPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.vatAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesSale.map((e) => double.parse(e.totalAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            context);
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
                                        child: Center(
                                            child: Text("Complete Sale",
                                                style: TextStyle(
                                                    color: Colors.white))),
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
                                                        child: searchQuotationTextField,
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
                                                        child: balanceQuotationValue == true
                                                            ? Text(
                                                          "Ksh ${CustomerApi.customersList[0].creditLimit}",
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
                                                          child: balanceQuotationValue ==
                                                              true
                                                              ? Text(
                                                            "Ksh ${CustomerApi.customersList[0].balance}",
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
                                                        child: branchQuotationTTextField,
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
                                                        child: itemQuotationTTextField,
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
                                                          child: itemQuotationValue ==
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
                                                          child: itemQuotationValue == true
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
                                                            child: itemQuotationValue == true
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
                                                            "Quotation item",
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
                                                          child: itemQuotationValue == true
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
                                                          _quotQuantityController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          _quotUnitPriceController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          _quotBonusController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          "${quotQty.floor() + quotBns.floor()}",
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
                                                          _quotDiscPercentageController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                    _editDiscTextField(),
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
                                                    _editQuotVATAmountTextField(),
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
                                                          _quotVatPercentageController,
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
                                                    _editQuotNetTextField(),
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
                                                          "${quotVat - quotDiscAmount + quotNetPrice}",
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
                                                    var tableQuotation = new TableQuotation();

                                                    tableQuotation.item = _quotItemController.text;
                                                    tableQuotation.bonus = _quotBonusController.text;
                                                    tableQuotation.totalQty = "${quotQty + quotBns}";
                                                    tableQuotation.quantity = _quotQuantityController.text;
                                                    tableQuotation.netAmount = _quotNetAmountController.text;
                                                    tableQuotation.unitPrice = _quotUnitPriceController.text;
                                                    tableQuotation.vatAmount = "${quotVatPerc.toPrecision(2) / 100 * quotNetPrice.toPrecision(2)}";
                                                    tableQuotation.vatPer = _quotVatPercentageController.text;
                                                    tableQuotation.disc = "${quotDiscPerc.toPrecision(2) / 100 * quotItemPrice.toPrecision(2)}";
                                                    tableQuotation.discPer = _quotDiscPercentageController.text;
                                                    tableQuotation.netAmount = "${quotItemPrice - quotDiscAmount}";
                                                    tableQuotation.totalAmount = "${quotVat - quotDiscAmount + quotNetPrice}";
                                                    tableQuotation.sumSubTotal = "${quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2) + quotNetPrice.toPrecision(2) - quotVat.toPrecision(2) + quotDiscAmount.toPrecision(2)}";
                                                    tableQuotation.sumNetAmount = "${quotNetPrice.toPrecision(2)}";
                                                    tableQuotation.sumDiscountTotal = "${quotDiscAmount.toPrecision(2)}";
                                                    tableQuotation.sumDiscountPercentage = "${quotDiscPerc.toPrecision(2)}";
                                                    tableQuotation.sumVatTotal = "${quotVat.toPrecision(2)}";
                                                    tableQuotation.sumTotal = "${quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2) + quotNetPrice.toPrecision(2) - quotVat.toPrecision(2) + quotDiscAmount.toPrecision(2) + quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2)}";
                                                    tablesQuotation.add(tableQuotation);
                                                    setState(() {

                                                    });

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
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        selectedQuotations.isEmpty != true
                                            ? InkWell(
                                          onTap: selectedQuotations.isEmpty
                                              ? null
                                              : () {
                                            deleteSelectedQuotation();
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
                                          sortAscending: sortQuotation,
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
                                                  onSortColumnQuotation(
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
                                          rows: tablesQuotation
                                              .map((e) => DataRow(
                                              selected: selectedQuotations
                                                  .contains(e),
                                              onSelectChanged: (b) {
                                                onSelectedRowQuotation(b, e);
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
                                              "Ksh${tablesQuotation.map((e) => double.parse(e.sumSubTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "- Ksh${tablesQuotation.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                                      "Ksh ${tablesQuotation.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "Ksh${tablesQuotation.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                      onTap: () async {

                                        quotationController.postSales(
                                            customerQuotationId,
                                            branchQuotationId,
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumDiscountPercentage)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            itemQuotationId,
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.quantity)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.unitPrice)).fold(0, (previousValue, element) => previousValue + element)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.bonus)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.totalQty)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.discPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.disc)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.netAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.vatPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.vatAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.totalAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            context);
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
                                        child: Center(
                                            child: Text("Complete Sale",
                                                style: TextStyle(
                                                    color: Colors.white))),
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
                                                        child: searchQuotationTextField,
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
                                                        child: balanceQuotationValue == true
                                                            ? Text(
                                                          "Ksh ${CustomerApi.customersList[0].creditLimit}",
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
                                                          child: balanceQuotationValue ==
                                                              true
                                                              ? Text(
                                                            "Ksh ${CustomerApi.customersList[0].balance}",
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
                                                        child: branchQuotationTTextField,
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
                                                        child: itemQuotationTTextField,
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
                                                          child: itemQuotationValue ==
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
                                                          child: itemQuotationValue == true
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
                                                            child: itemQuotationValue == true
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
                                                            "Quotation item",
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
                                                          child: itemQuotationValue == true
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
                                                          _quotQuantityController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          _quotUnitPriceController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          _quotBonusController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                          "${quotQty.floor() + quotBns.floor()}",
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
                                                          _quotDiscPercentageController,
                                                          keyboardType:
                                                          TextInputType.number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                                                    _editDiscTextField(),
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
                                                    _editQuotVATAmountTextField(),
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
                                                          _quotVatPercentageController,
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
                                                    _editQuotNetTextField(),
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
                                                          "${quotVat - quotDiscAmount + quotNetPrice}",
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
                                                    var tableQuotation = new TableQuotation();

                                                    tableQuotation.item = _quotItemController.text;
                                                    tableQuotation.bonus = _quotBonusController.text;
                                                    tableQuotation.totalQty = "${quotQty + quotBns}";
                                                    tableQuotation.quantity = _quotQuantityController.text;
                                                    tableQuotation.netAmount = _quotNetAmountController.text;
                                                    tableQuotation.unitPrice = _quotUnitPriceController.text;
                                                    tableQuotation.vatAmount = "${quotVatPerc.toPrecision(2) / 100 * quotNetPrice.toPrecision(2)}";
                                                    tableQuotation.vatPer = _quotVatPercentageController.text;
                                                    tableQuotation.disc = "${quotDiscPerc.toPrecision(2) / 100 * quotItemPrice.toPrecision(2)}";
                                                    tableQuotation.discPer = _quotDiscPercentageController.text;
                                                    tableQuotation.netAmount = "${quotItemPrice - quotDiscAmount}";
                                                    tableQuotation.totalAmount = "${quotVat - quotDiscAmount + quotNetPrice}";
                                                    tableQuotation.sumSubTotal = "${quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2) + quotNetPrice.toPrecision(2) - quotVat.toPrecision(2) + quotDiscAmount.toPrecision(2)}";
                                                    tableQuotation.sumNetAmount = "${quotNetPrice.toPrecision(2)}";
                                                    tableQuotation.sumDiscountTotal = "${quotDiscAmount.toPrecision(2)}";
                                                    tableQuotation.sumDiscountPercentage = "${quotDiscPerc.toPrecision(2)}";
                                                    tableQuotation.sumVatTotal = "${quotVat.toPrecision(2)}";
                                                    tableQuotation.sumTotal = "${quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2) + quotNetPrice.toPrecision(2) - quotVat.toPrecision(2) + quotDiscAmount.toPrecision(2) + quotVat.toPrecision(2) - quotDiscAmount.toPrecision(2)}";
                                                    tablesQuotation.add(tableQuotation);
                                                    setState(() {

                                                    });

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
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        selectedQuotations.isEmpty != true
                                            ? InkWell(
                                          onTap: selectedQuotations.isEmpty
                                              ? null
                                              : () {
                                            deleteSelectedQuotation();
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
                                          sortAscending: sortQuotation,
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
                                                  onSortColumnQuotation(
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
                                          rows: tablesQuotation
                                              .map((e) => DataRow(
                                              selected: selectedQuotations
                                                  .contains(e),
                                              onSelectChanged: (b) {
                                                onSelectedRowQuotation(b, e);
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
                                              "Ksh${tablesQuotation.map((e) => double.parse(e.sumSubTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "- Ksh${tablesQuotation.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                                      "Ksh ${tablesQuotation.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                              "Ksh${tablesQuotation.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}",
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
                                      onTap: () async {

                                        quotationController.postSales(
                                            customerQuotationId,
                                            branchQuotationId,
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumDiscountTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumNetAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumVatTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumTotal)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.sumDiscountPercentage)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            itemQuotationId,
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.quantity)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.unitPrice)).fold(0, (previousValue, element) => previousValue + element)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.bonus)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.totalQty)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.discPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.disc)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.netAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.vatPer)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.vatAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            double.parse(
                                                "${tablesQuotation.map((e) => double.parse(e.totalAmount)).fold(0, (previousValue, current) => previousValue + current)}"),
                                            context);
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
                                        child: Center(
                                            child: Text("Complete Sale",
                                                style: TextStyle(
                                                    color: Colors.white))),
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
              ]),
        )
      ],
    );
  }
}



class CustomerApi {
  static List<Customers> customersList = <Customers>[];

  static Future<List<Customers>> getCustomersSuggestions(
      String query, BuildContext context) async {
    Auth user = Provider.of<AuthProvider>(context, listen: false).auth;
    final response = await http.get(
      Uri.parse('${AppUrl.customers}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer ${user.accessToken.toString()}"
      },
    );
    if (response.statusCode == 200) {
      final Map customers = json.decode(response.body);
      var categoryJson = customers['results'] as List;
      print("Json customers: ${categoryJson}");
      for (int i = 0; i < categoryJson.length; i++) {
        customersList.add(new Customers.fromJson(categoryJson[i]));
        print("${CustomerApi.customersList[0].creditLimit}");
      }
      return categoryJson
          .map((json) => Customers.fromJson(json))
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
