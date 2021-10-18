import 'package:serow/models/inventory/subgroups.dart';

abstract class SubgroupRepository {
//subgroups
  Future<List<Results>> getSubGroupList();

  Future<String> patchSubGroup(Results groups);

  Future<String> putSubGroup(Results groups);

  Future<Results> deletedSubGroup(String id);

  Future<Subgroups> postSubGroup(String name, String groupId);

}