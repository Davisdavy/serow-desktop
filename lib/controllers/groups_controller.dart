import 'package:serow/models/inventory/groups.dart';
import 'package:serow/respository/group_repository.dart';

class GroupsController{
  final GroupsRepository _repository;
  GroupsController(this._repository);

  //get
  Future<List<Results> >fetchGroupsList(){
    return _repository.getGroupList();
  }

  //patch
  Future<String >updatePatchCompleted(Results groups) async{
    return _repository.patchGroup(groups);
  }

  //put
  Future<String >updatePutCompleted(Results groups) async{
    return _repository.putGroup(groups);
  }

  //delete
  Future<void>deleteGroup(String id) async{
    return _repository.deletedGroup(id);
  }

  //delete
  Future<Groups>postGroup(String name, String priority) async{
    return _repository.postGroup(name,priority);
  }
}