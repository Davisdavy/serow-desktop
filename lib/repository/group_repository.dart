
import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/groups.dart';

abstract class GroupsRepository {
//Groups
  Future<List<Results>> getGroupList(BuildContext context);

  Future<String> patchGroup(Results groups);

  Future<String> putGroup(Results groups);

  Future<Results> deletedGroup(String id, BuildContext context);

  Future<Group> postGroup(String name, String priority, BuildContext context);
}