

import 'package:flutter/cupertino.dart';
import 'package:serow/models/inventory/strengths.dart';
import 'package:serow/respository/strengths_repository.dart';

class StrengthsController{
  final StrengthsRepository _repository;
  StrengthsController(this._repository);

  //get
  Future<List<Results> >fetchStrengthsList(BuildContext context){
    return _repository.getStrengthsList(context);
  }

  //patch
  Future<String >updatePatchCompleted(Results result) async{
    return _repository.patchStrength(result);
  }

  //put
  Future<String >updatePutCompleted(Results result) async{
    return _repository.putStrength(result);
  }

  //delete
  Future<String>deleteStrength(String id, BuildContext context) async{
    return _repository.deletedStrength(id, context);
  }

  //delete
  Future<Strengths>postStrength(String name, String shortName, BuildContext context) async{
    return _repository.postStrength(name,shortName, context);
  }
}