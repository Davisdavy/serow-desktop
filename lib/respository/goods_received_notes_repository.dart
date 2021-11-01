
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_received_notes.dart';

abstract class GoodsReceivedNotesRepository {
  //Brands
  Future<List<Results>> getGoodsReceivedNoteList(BuildContext context);
  Future<String> patchGoodsReceivedNote(Results result);
  Future<String> putGoodsReceivedNote(Results result);
  Future<Results> deletedGoodsReceivedNote(String id, BuildContext context);
  Future<GoodsReceivedNotes> postGoodsReceivedNote(String supplier, String branch,List<String>grn_items, BuildContext context);


}