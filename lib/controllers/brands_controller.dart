import 'package:serow/models/inventory/brands.dart';
import 'package:serow/respository/repository.dart';

class BrandsController{
  final Repository _repository;
  BrandsController(this._repository);

  //get
  Future<List<Result> >fetchBrandList(){
    return _repository.getBrandList();
  }
}