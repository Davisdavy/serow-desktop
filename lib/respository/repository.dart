import 'package:serow/models/inventory/brands.dart';

abstract class Repository {
  Future<List<Result>> getBrandList();
  Future<String> patchCompleted(Result result);
  Future<String> putCompleted(Result result);
  Future<String> deletedBrand(Result result);
  Future<String> postBrand(Brands brands);


}