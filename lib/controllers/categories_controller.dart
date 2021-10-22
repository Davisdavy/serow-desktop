import 'package:flutter/material.dart';
import 'package:serow/models/inventory/categories.dart';
import 'package:serow/respository/categories_repository.dart';

class CategoriesController{
  final CategoriesRepository _repository;
  CategoriesController(this._repository);

  //get
  Future<List<Result> >fetchCategoryList(BuildContext context){
    return _repository.getCategoryList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Result categories) async{
    return _repository.patchCategory(categories);
  }

  //put
  Future<String >updatePutCompleted(Result categories) async{
    return _repository.putCategory(categories);
  }

  //delete
  Future<void>deleteCategory(String id,BuildContext context) async{
    return _repository.deletedCategory(id, context);
  }

  //post
  Future<Categories>postCategory(String name, String groupId, String subgroupId,  BuildContext context) async{
    return _repository.postCategory(name,groupId,subgroupId, context);
  }
}