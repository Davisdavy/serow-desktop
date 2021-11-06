


import 'package:flutter/material.dart';
import 'package:serow/models/suppliers/posting_categories.dart';
import 'package:serow/repository/posting_categories_repository.dart';


class PostingCategoriesController{
  final PostingCategoriesRepository _repository;
  PostingCategoriesController(this._repository);

  //get
  Future<List<Results> >fetchPostingCategoryList(BuildContext context){
    return _repository.getPostingCategoryList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results groups) async{
    return _repository.patchPostingCategory(groups);
  }

  //put
  Future<String >updatePutCompleted(Results groups) async{
    return _repository.putPostingCategory(groups);
  }

  //delete
  Future<String>deletePostingCategory(String id, BuildContext context) async{
    return _repository.deletedPostingCategory(id, context);
  }

  //delete
  Future<PostingCategories>postPostingCategory(String name,String code, String accountId, BuildContext context) async{
    return _repository.postPostingCategory(name, name, accountId, context);
  }
}