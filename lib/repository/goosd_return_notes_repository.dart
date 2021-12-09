

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';

abstract class GoodsReturnNotesRepository {
  //Brands
  Future<List<GoodsReturnNotes>> getGoodsReturnNoteList(BuildContext context);
  Future<String> patchGoodsReturnNote(GoodsReturnNotes result);
  Future<String> putGoodsReturnNote(GoodsReturnNotes result);
  Future<String> deletedGoodsReturnNote(String id, BuildContext context);
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,
      String supplierInvoiceId, double tradeDiscPercentage,
      double discountAmount, double totalNet, double vatAmount,
      double totalAmount, List<Map<String, dynamic>> listItems,
      BuildContext context);


}