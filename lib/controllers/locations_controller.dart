
import 'package:serow/models/inventory/locations.dart';
import 'package:serow/respository/locations_repository.dart';

class LocationsController{
  final LocationsRepository _repository;
  LocationsController(this._repository);

  //get
  Future<List<Results> >fetchLocationsList(){
    return _repository.getLocationList();
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
  Future<void>deleteLocations(String id) async{
    return _repository.deletedLocation(id);
  }

  //delete
  Future<Locations>postLocations(String name, String code, String branchId) async{
    return _repository.postLocation(name, code,branchId);
  }
}