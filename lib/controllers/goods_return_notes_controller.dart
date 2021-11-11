import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';
import 'package:serow/repository/goosd_return_notes_repository.dart';

class GoodsReturnNotesController {
  final GoodsReturnNotesRepository _repository;
  GoodsReturnNotesController(this._repository);
//get
  Future<List<Results>> fetchGoodsReturnNotesList(BuildContext context) {
    return _repository.getGoodsReturnNoteList(context);
  }

  //patch
  Future<String> updatePatchCompleted(Results result) async {
    return _repository.patchGoodsReturnNote(result);
  }

  //put
  Future<String> updatePutCompleted(Results result) async {
    return _repository.putGoodsReturnNote(result);
  }

  //delete
  Future<String> deleteGoodsReturnNote(String id, BuildContext context) async {
    return _repository.deletedGoodsReturnNote(id, context);
  }

  //delete
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,
      String item, int quantity, int detailQuantity, String detailLocation, double discountAmount,
      String batchNo, String expDate,double totalAmount, double totalCost,
      BuildContext context) async {
    return _repository.postGoodsReturnNote(
        supplier, branch, item, quantity, detailQuantity,
        detailLocation,discountAmount, batchNo, expDate,
        totalAmount, totalCost,
        context);
  }
}
