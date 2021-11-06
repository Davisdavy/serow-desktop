

import 'package:flutter/material.dart';
import 'package:serow/models/entities/branches.dart';

abstract class BranchesRepository {
  //Brands
  Future<List<Results>> getBranchList(BuildContext context);
  Future<String> patchBranch(Results result);
  Future<String> putBranch(Results result);
  Future<String> deletedBranch(String id, BuildContext context);
  Future<Branches> postBranch(String name, String location, String phone, BuildContext context);
}