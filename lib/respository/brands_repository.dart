import 'package:serow/models/inventory/brands.dart';


abstract class BrandsRepository {
  //Brands
  Future<List<Results>> getBrandList();
  Future<String> patchBrand(Results result);
  Future<String> putBrand(Results result);
  Future<Results> deletedBrand(String id);
  Future<Brands> postBrand(String name, String shortName, String country);


}