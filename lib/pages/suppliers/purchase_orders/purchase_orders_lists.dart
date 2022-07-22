import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serow/constants.dart';
import 'package:serow/pages/suppliers/purchase_orders/purchase_orders.dart';
import 'package:serow/widgets/custom_text.dart';
class PurchaseOrderList extends StatefulWidget {
  const PurchaseOrderList({Key key}) : super(key: key);

  @override
  _PurchaseOrderListState createState() => _PurchaseOrderListState();
}

class _PurchaseOrderListState extends State<PurchaseOrderList> {
  List<TablePurchaseOrder> tablesPurchaseOrder;
  List<TablePurchaseOrder> selectedPurchaseOrders;
  bool sort;
  @override
  void initState() {

    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      text: "List",
                      size: 28,
                      color: bgColor,
                      weight: FontWeight.bold,
                    ),
                  )),

            ],
          ),
        ),
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
                  "Unit Cost",
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
              selected:
              selectedPurchaseOrders
                  .contains(e),
              onSelectChanged: (b) {
                onSelectedRow(b, e);
              },
              cells: [
                DataCell(Text(
                  e.item.toString(),
                  style: TextStyle(
                      color: bgColor,
                      fontSize: 10,
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
                          fontSize: 10,
                          fontWeight:
                          FontWeight
                              .bold)),
                ),
                DataCell(
                  Text(
                    e.bonus.toString(),
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
                    e.totalQty
                        .toString(),
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
                    e.disc.toString(),
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
                    e.discPer
                        .toString(),
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
                    e.unitPrice
                        .toString(),
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
                    e.netAmount
                        .toString(),
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
                    "${Decimal.parse(e.vatAmount.toString())}",
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
                    e.vatPer.toString(),
                    style: TextStyle(
                        color: bgColor,
                        fontSize: 10,
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
                      fontSize: 10,
                      fontWeight:
                      FontWeight
                          .bold),
                )),
              ]))
              .toList(),
        ),
      ],
    );
  }
}
