

import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';

abstract class GoodsReturnNotesRepository {
  //Brands
  Future<List<Results>> getGoodsReturnNoteList(BuildContext context);
  Future<String> patchGoodsReturnNote(Results result);
  Future<String> putGoodsReturnNote(Results result);
  Future<String> deletedGoodsReturnNote(String id, BuildContext context);
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,List<String>goods_return_note_items, BuildContext context);


}