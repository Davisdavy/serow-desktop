import 'package:serow/models/inventory/subgroups.dart';
import 'package:serow/respository/subgroup_repository.dart';

class SubgroupController{
  final SubgroupRepository _repository;
  SubgroupController(this._repository);

  //get
  Future<List<Results> >fetchSubgroupsList(){
    return _repository.getSubGroupList();
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
  Future<void>deleteSubgroup(String id) async{
    return _repository.deletedSubGroup(id);
  }

  //delete
  Future<Subgroups>postSubgroup(String name, String groupId) async{
    return _repository.postSubGroup(name,groupId);
  }
}