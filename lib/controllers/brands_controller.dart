import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/brands_repository.dart';

class BrandsController{
  final BrandsRepository _repository;
  BrandsController(this._repository);

  //get
  Future<List<Results> >fetchBrandList(){
    return _repository.getBrandList();
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchBrand(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putBrand(result);
  }

  //delete
  Future<void>deleteBrand(String id) async{
    return _repository.deletedBrand(id);
  }

  //delete
  Future<Brands>postBrand(String name, String shortName, String country) async{
    return _repository.postBrand(name,shortName,country);
  }
}