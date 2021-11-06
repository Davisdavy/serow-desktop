import 'package:flutter/material.dart';
import 'package:serow/models/inventory/items.dart';
import 'package:serow/repository/items_repository.dart';

class ItemsController{
  final ItemsRepository _repository;
  ItemsController(this._repository);

  //get
  Future<List<Results> >fetchItemList(BuildContext context){
    return _repository.getItemList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results subgroups) async{
    return _repository.patchItem(subgroups);
  }

  //put
  Future<String >updatePutCompleted(Results subgroups) async{
    return _repository.patchItem(subgroups);
  }

  //delete
  Future<String>deleteItem(String id, BuildContext context) async{
    return _repository.deletedItem(id, context);
  }

  //delete
  Future<Items>postItem(String name, String branchId, String groupId, String subgroupId, BuildContext context) async{
    return _repository.postItem(name, branchId, groupId, subgroupId, context);
  }
}