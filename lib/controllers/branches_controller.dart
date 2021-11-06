
import 'package:flutter/material.dart';
import 'package:serow/models/entities/branches.dart';
import 'package:serow/repository/branches_repository.dart';

class BranchesController{
  final BranchesRepository _repository;
  BranchesController(this._repository);

  //get
  Future<List<Results> >fetchBranchList(BuildContext context){
    return _repository.getBranchList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchBranch(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putBranch(result);
  }

  //delete
  Future<String>deleteBranch(String id, BuildContext context) async{
    return _repository.deletedBranch(id, context);
  }

  //delete
  Future<Branches>postBrand(String name, String shortName, String country, BuildContext context) async{
    return _repository.postBranch(name,shortName,country, context);
  }
}