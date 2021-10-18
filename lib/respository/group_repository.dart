
import 'package:serow/models/inventory/groups.dart';

abstract class GroupsRepository {
//Groups
  Future<List<Results>> getGroupList();

  Future<String> patchGroup(Results groups);

  Future<String> putGroup(Results groups);

  Future<Results> deletedGroup(String id);

  Future<Groups> postGroup(String name, String priority);
}