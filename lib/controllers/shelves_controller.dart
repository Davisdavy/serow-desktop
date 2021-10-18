


import 'package:serow/models/inventory/shelves.dart';
import 'package:serow/respository/shelves_repository.dart';

class ShelvesController{
  final ShelvesRepository _repository;
  ShelvesController(this._repository);

  //get
  Future<List<Results> >fetchShelvesList(){
    return _repository.getShelveList();
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
  Future<void>deleteShelf(String id) async{
    return _repository.deletedShelf(id);
  }

  //delete
  Future<Shelves>postShelf(String name,String locationId) async{
    return _repository.postShelf(name, locationId);
  }
}