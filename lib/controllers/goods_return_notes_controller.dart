import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_return_notes.dart';
import 'package:serow/repository/goosd_return_notes_repository.dart';

class GoodsReturnNotesController {
  final GoodsReturnNotesRepository _repository;
  GoodsReturnNotesController(this._repository);
//get
  Future<List<GoodsReturnNotes>> fetchGoodsReturnNotesList(BuildContext context) {
    return _repository.getGoodsReturnNoteList(context);
  }

  //patch
  Future<String> updatePatchCompleted(GoodsReturnNotes result) async {
    return _repository.patchGoodsReturnNote(result);
  }

  //put
  Future<String> updatePutCompleted(GoodsReturnNotes result) async {
    return _repository.putGoodsReturnNote(result);
  }

  //delete
  Future<String> deleteGoodsReturnNote(String id, BuildContext context) async {
    return _repository.deletedGoodsReturnNote(id, context);
  }

  //delete
  Future<GoodsReturnNotes> postGoodsReturnNote(String supplier, String branch,
      String supplierInvoiceId, double tradeDiscPercentage,
      double discountAmount, double totalNet, double vatAmount,
      double totalAmount, List<Map<String, dynamic>> listItems,
      BuildContext context) async {
    return _repository.postGoodsReturnNote(
         supplier,  branch,
        supplierInvoiceId,  tradeDiscPercentage,
         discountAmount,  totalNet,  vatAmount,
         totalAmount, listItems,
         context);
  }
}
