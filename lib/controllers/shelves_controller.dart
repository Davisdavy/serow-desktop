


import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/shelves.dart';
import 'package:serow/respository/shelves_repository.dart';

class ShelvesController{
  final ShelvesRepository _repository;
  ShelvesController(this._repository);

  //get
  Future<List<Results> >fetchShelvesList(BuildContext context){
    return _repository.getShelveList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results groups) async{
    return _repository.patchShelf(groups);
  }

  //put
  Future<String >updatePutCompleted(Results groups) async{
    return _repository.putShelf(groups);
  }

  //delete
  Future<String>deleteShelf(String id, BuildContext context) async{
    return _repository.deletedShelf(id, context);
  }

  //delete
  Future<Shelves>postShelf(String name,String locationId, BuildContext context) async{
    return _repository.postShelf(name, locationId, context);
  }
}