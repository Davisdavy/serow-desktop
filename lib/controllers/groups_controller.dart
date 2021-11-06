import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/groups.dart';
import 'package:serow/repository/group_repository.dart';

class GroupsController{
  final GroupsRepository _repository;
  GroupsController(this._repository);

  //get
  Future<List<Results> >fetchGroupsList(BuildContext context){
    return _repository.getGroupList(context);
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
  Future<void>deleteGroup(String id, BuildContext context) async{
    return _repository.deletedGroup(id, context);
  }

  //delete
  Future<Group>postGroup(String name, String priority, BuildContext context) async{
    return _repository.postGroup(name,priority, context);
  }
}