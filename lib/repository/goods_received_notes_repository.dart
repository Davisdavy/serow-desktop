
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_received_notes.dart';

abstract class GoodsReceivedNotesRepository {
  //Brands
  Future<List<Results>> getGoodsReceivedNoteList(BuildContext context);
  Future<String> patchGoodsReceivedNote(Results result);
  Future<String> putGoodsReceivedNote(Results result);
  Future<String> deletedGoodsReceivedNote(String id, BuildContext context);
  Future<GoodsReceivedNotes> postGoodsReceivedNote(String supplier, String branch,
      String grnItemId, int grnQuantity,
      double grnDiscountAmount, double grnTotalCost,
      double grnDiscountPercentage, double totalAmount,
      double discountAmount,
      BuildContext context);


}