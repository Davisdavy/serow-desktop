

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';

abstract class GoodsReturnNotesRepository {
  //Brands
  Future<List<Results>> getGoodsReturnNoteList(BuildContext context);
  Future<String> patchGoodsReturnNote(Results result);
  Future<String> putGoodsReturnNote(Results result);
  Future<String> deletedGoodsReturnNote(String id, BuildContext context);
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,
      String item, int quantity, int detailQuantity, String detailLocation, double discountAmount,
      String batchNo, String expDate, double totalAmount, double totalCost,
      BuildContext context);


}