import 'package:flutter/material.dart';
import 'package:serow/models/inventory/categories.dart';

abstract class CategoriesRepository {
//categories
  Future<List<Result>> getCategoryList(BuildContext context);

  Future<String> patchCategory(Result categories);

  Future<String> putCategory(Result categories);

  Future<dynamic> deletedCategory(String id, BuildContext context);

  Future<Categories> postCategory(String name, String shortName,
      String country, BuildContext context);
}