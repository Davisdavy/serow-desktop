
import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/locations.dart';
import 'package:serow/respository/locations_repository.dart';

class LocationsController{
  final LocationsRepository _repository;
  LocationsController(this._repository);

  //get
  Future<List<Results> >fetchLocationsList(BuildContext context){
    return _repository.getLocationList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results groups) async{
    return _repository.patchLocation(groups);
  }

  //put
  Future<String >updatePutCompleted(Results groups) async{
    return _repository.putLocation(groups);
  }

  //delete
  Future<String>deleteLocations(String id, BuildContext context) async{
    return _repository.deletedLocation(id, context);
  }

  //delete
  Future<Locations>postLocations(String name, String code, String branchId, BuildContext context) async{
    return _repository.postLocation(name, code,branchId, context);
  }
}