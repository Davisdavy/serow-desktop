
import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/goods_received_notes.dart';
import 'package:serow/repository/goods_received_notes_repository.dart';

class GoodsReceivedNotesController{
  final GoodsReceivedNotesRepository _repository;
  GoodsReceivedNotesController(this._repository);
//get
  Future<List<Results> >fetchGoodsReceivedNote(BuildContext context){
    return _repository.getGoodsReceivedNoteList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchGoodsReceivedNote(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putGoodsReceivedNote(result);
  }

  //delete
  Future<String>deleteGoodsReceivedNote(String id, BuildContext context) async{
    return _repository.deletedGoodsReceivedNote(id, context);
  }

  //delete
  Future<GoodsReceivedNotes>postGoodsReceivedNote(String supplier,
      String branch,String grnItemId,
      int grnQuantity,double grnDiscountAmount,
      double grnTotalCost, double grnDiscountPercentage,
      double totalAmount, double discountAmount,  BuildContext context) async{
    return _repository.postGoodsReceivedNote(supplier, branch,
        grnItemId, grnQuantity, grnDiscountAmount,grnTotalCost,
        grnDiscountPercentage, totalAmount, discountAmount,
        context);
  }
}