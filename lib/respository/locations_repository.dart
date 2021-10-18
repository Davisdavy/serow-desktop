
import 'package:serow/models/inventory/locations.dart';

abstract class LocationsRepository {
//subgroups
  Future<List<Results>> getLocationList();

  Future<String> patchLocation(Results groups);

  Future<String> putLocation(Results groups);

  Future<Results> deletedLocation(String id);

  Future<Locations> postLocation(String name, String code, String branchId);

}