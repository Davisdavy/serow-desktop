


import 'package:serow/models/inventory/shelves.dart';

abstract class ShelvesRepository {
//subgroups
  Future<List<Results>> getShelveList();

  Future<String> patchShelf(Results groups);

  Future<String> putShelf(Results groups);

  Future<Results> deletedShelf(String id);

  Future<Shelves> postShelf(String name, String locationId);

}