

import 'package:flutter/material.dart';
import 'package:serow/models/inventory/items.dart';

abstract class ItemsRepository {
//subgroups
  Future<List<Results>> getItemList(BuildContext context);

  Future<String> patchItem(Results groups);

  Future<String> putItem(Results groups);

  Future<String> deletedItem(String id, BuildContext context);

  Future<Items> postItem(String name, String brandId, String groupId, String subgroupId,
      String description,
      double costPrice,
      double avgPrice,
      double tradePrice,
      double retailPrice,
      double minimumPrice,
      double maximumPrice,
      double wholesalePrice,
      double minWholesalePrice,
      double maxWholesalePrice,
      double supplierPrice,
      double vatPercentage,
      double specialPrice,
      String packSize,
      String availability,
      int priority,
      String sellingOptions,
      double balance,
      double totalRevenue,
      double totalPurchases,
      BuildContext context );

}