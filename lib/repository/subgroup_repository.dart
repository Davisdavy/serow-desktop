import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/subgroups.dart';

abstract class SubgroupRepository {
//subgroups
  Future<List<Results>> getSubGroupList(BuildContext context);

  Future<String> patchSubGroup(Results groups);

  Future<String> putSubGroup(Results groups);

  Future<Results> deletedSubGroup(String id, BuildContext context);

  Future<Subgroup> postSubGroup(String name, String groupId, BuildContext context);

}