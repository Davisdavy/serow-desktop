

import 'package:flutter/material.dart';
import 'package:serow/models/entities/branches.dart';

abstract class BranchesRepository {
  //Brands
  Future<List<Branches>> getBranchList(BuildContext context);
  Future<String> patchBranch(Branches result);
  Future<String> putBranch(Branches result);
  Future<String> deletedBranch(String id, BuildContext context);
  Future<Branches> postBranch(String name, String location, String phone, BuildContext context);
}