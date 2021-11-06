
import 'package:flutter/material.dart';
import 'package:serow/models/inventory/locations.dart';

abstract class LocationsRepository {
//subgroups
  Future<List<Results>> getLocationList(BuildContext context);

  Future<String> patchLocation(Results groups);

  Future<String> putLocation(Results groups);

  Future<String> deletedLocation(String id, BuildContext context);

  Future<Locations> postLocation(String name, String code, String branchId, BuildContext context);

}