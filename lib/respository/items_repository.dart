

import 'package:flutter/material.dart';
import 'package:serow/models/inventory/items.dart';

abstract class ItemsRepository {
//subgroups
  Future<List<Results>> getItemList(BuildContext context);

  Future<String> patchItem(Results groups);

  Future<String> putItem(Results groups);

  Future<String> deletedItem(String id, BuildContext context);

  Future<Items> postItem(String name, String brandId, String groupId, String subgroupId,BuildContext context );

}