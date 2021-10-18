import 'package:serow/models/inventory/categories.dart';
import 'package:serow/respository/categories_repository.dart';

class CategoriesController{
  final CategoriesRepository _repository;
  CategoriesController(this._repository);

  //get
  Future<List<Result> >fetchCategoryList(){
    return _repository.getCategoryList();
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
  Future<void>deleteCategory(String id) async{
    return _repository.deletedCategory(id);
  }

  //post
  Future<Categories>postCategory(String name, String groupId, String subgroupId) async{
    return _repository.postCategory(name,groupId,subgroupId);
  }
}