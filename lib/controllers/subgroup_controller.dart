import 'package:flutter/material.dart';
import 'package:serow/models/inventory/subgroups.dart';
import 'package:serow/repository/subgroup_repository.dart';

class SubgroupController{
  final SubgroupRepository _repository;
  SubgroupController(this._repository);

  //get
  Future<List<Results> >fetchSubgroupsList(BuildContext context){
    return _repository.getSubGroupList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results subgroups) async{
    return _repository.patchSubGroup(subgroups);
  }

  //put
  Future<String >updatePutCompleted(Results subgroups) async{
    return _repository.putSubGroup(subgroups);
  }

  //delete
  Future<void>deleteSubgroup(String id, BuildContext context) async{
    return _repository.deletedSubGroup(id, context);
  }

  //delete
  Future<Subgroup>postSubgroup(String name, String groupId, BuildContext context) async{
    return _repository.postSubGroup(name,groupId, context);
  }
}