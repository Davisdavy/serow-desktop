


import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/shelves.dart';

abstract class ShelvesRepository {
//subgroups
  Future<List<Results>> getShelveList(BuildContext context);

  Future<String> patchShelf(Results groups);

  Future<String> putShelf(Results groups);

  Future<String> deletedShelf(String id, BuildContext context);

  Future<Shelves> postShelf(String name, String locationId, BuildContext context);

}