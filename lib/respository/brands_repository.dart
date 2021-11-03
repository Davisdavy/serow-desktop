import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/brands.dart';


abstract class BrandsRepository {
  //Brands
  Future<List<Results>> getBrandList(BuildContext context);
  Future<String> patchBrand(Results result);
  Future<String> putBrand(Results result);
  Future<dynamic> deletedBrand(String id, BuildContext context);
  Future<Brands> postBrand(String name, String shortName, String country, BuildContext context);


}