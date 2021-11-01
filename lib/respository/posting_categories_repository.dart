
import 'package:flutter/cupertino.dart';
import 'package:serow/models/suppliers/posting_categories.dart';

abstract class PostingCategoriesRepository {
//subgroups
  Future<List<Results>> getPostingCategoryList(BuildContext context);

  Future<String> patchPostingCategory(Results groups);

  Future<String> putPostingCategory(Results groups);

  Future<Results> deletedPostingCategory(String id, BuildContext context);

  Future<PostingCategories> postPostingCategory(String name, String code, String accountId,BuildContext context);

}