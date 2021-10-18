import 'package:serow/models/inventory/categories.dart';

abstract class CategoriesRepository {
//categories
  Future<List<Result>> getCategoryList();

  Future<String> patchCategory(Result categories);

  Future<String> putCategory(Result categories);

  Future<Result> deletedCategory(String id);

  Future<Categories> postCategory(String name, String shortName,
      String country);
}